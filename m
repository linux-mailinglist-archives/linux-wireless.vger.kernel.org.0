Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F395774B7A
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Aug 2023 22:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbjHHUse (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Aug 2023 16:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbjHHUsR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Aug 2023 16:48:17 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC75E157AF
        for <linux-wireless@vger.kernel.org>; Tue,  8 Aug 2023 09:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=8YfCtcbe4WPmkqSYcWXFF4mhHo97h/r2CF3qRV1YvRU=;
        t=1691512828; x=1692722428; b=YvtWi+TJjW+x9rkOogJe1YVR6/Jup94JukC42D5s/ZMz71I
        1WhSKZDbVfYWE5yV4HiA6jRk6HVDCfHkySMy/jOp+ZxQ8M7DZVFAjkLR9Y4bgi4oe5nW0v8DFq2SC
        xjsKEUtW7bsEzrMszAZ+SaepN9VGzr3G89+JEXixeYDDfZgjkAKy0mpfE7Jw+93BhlOguV90U4fHo
        KpcJV815o/mr+BOL4DnWCl9heErEmrC7EaBROYt2y1juPbLAv6FJliDCoa/M/ZyWGM8CTtSTijkKE
        NTHDDdiGS/yxJLTvQ5QEeEKrtlyV7g6S1mxPVqvU/q9GQOwYnzCf7mPHottHLXLQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qTKNL-00CZrr-22;
        Tue, 08 Aug 2023 12:55:43 +0200
Message-ID: <6ccf4549011f0efa67523d1c171b23694122ec6c.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: ath12k: Fix buffer overflow when scanning with
 extraie
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 08 Aug 2023 12:55:42 +0200
In-Reply-To: <20230807030806.9345-1-quic_wgong@quicinc.com>
References: <20230807030806.9345-1-quic_wgong@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Since I'm covering for Kalle right now ...

On Sun, 2023-08-06 at 23:08 -0400, Wen Gong wrote:
> If cfg80211 is providing extraie's for a scanning process then ath12k wil=
l
> copy that over to the firmware. The extraie.len is a 32 bit value in stru=
ct
> element_info and describes the amount of bytes for the vendor information
> elements.
>=20
> The WMI_TLV packet is having a special WMI_TAG_ARRAY_BYTE section. This
> section can have a (payload) length up to 65535 bytes because the
> WMI_TLV_LEN can store up to 16 bits. The code was missing such a check an=
d
> could have created a scan request which cannot be parsed correctly by the
> firmware.
>=20
> But the bigger problem was the allocation of the buffer. It has to align
> the TLV sections by 4 bytes. But the code was using an u8 to store the
> newly calculated length of this section (with alignment). And the new
> calculated length was then used to allocate the skbuff. But the actual co=
de
> to copy in the data is using the extraie.len and not the calculated
> "aligned" length.
>=20
> The length of extraie with IEEE80211_HW_SINGLE_SCAN_ON_ALL_BANDS enabled
> was 264 bytes during tests with a wifi card. But it only allocated 8
> bytes (264 bytes % 256) for it. As consequence, the code to memcpy the
> extraie into the skb was then just overwriting data after skb->end. Thing=
s
> like shinfo were therefore corrupted. This could usually be seen by a cra=
sh
> in skb_zcopy_clear which tried to call a ubuf_info callback (using a bogu=
s
> address).

I feel these are two separate issues. Having a large enough TLV that the
firmware cannot parse it is highly unlikely to happen, and not really an
issue here.

Please split this into two patches, and fix *just* the buffer overflow
in a patch titled "Fix buffer overflow". I believe simply changing the
variable type is sufficient for this, as the code is otherwise
equivalent. That's a patch I'd take to wireless at this stage (rc5), but
probably not the entire bigger change.

johannes

