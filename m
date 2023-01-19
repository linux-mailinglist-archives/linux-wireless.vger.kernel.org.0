Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEBE673D98
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 16:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjASPfP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 10:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjASPez (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 10:34:55 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D404829AA
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 07:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=H5xSKqQIOzL3LAEAGuUdPac2qk1i3UA2tek1OM85XbM=;
        t=1674142447; x=1675352047; b=wzHE650aEUrozOWjtxMUEarSkifYrIe+IeRSnFSouCHaHWK
        ztJ5ym3mR8Ql+oK+TJyLnok4GSet5VnJuP1xWpiHEbg//9sdVfM7ySQmEfBY5scsu2Ym+ZLq/kBWE
        6mz+VOCSDOE9CQEoH3nF1bZfkQYcC3rVviIN7QRT/+Qt6nzzNVri8VqLV9HjNBYq6xgcfb8cI3r5J
        EztqF1M9qMBl3o8/kgPSzc2FVQcFvFYkO71Rrslp0RV6VMLAIIa3tLDQpMzobiYWdPPmTnCXbejx/
        uyZulYRbR/bYkZt3tTCX02vfnxaEbiw4bI+5MMHLlH/yT5V74b5YCz4ONJHyqtSA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pIWvV-006Yr4-0G;
        Thu, 19 Jan 2023 16:34:05 +0100
Message-ID: <b7eb7ae9ae1b24ae7f6ac5fc8cb50ed3840a61f5.camel@sipsolutions.net>
Subject: Re: [RFC 2/4] wifi: cfg80211: RU puncturing bitmap
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Muna Sinada <quic_msinada@quicinc.com>
Cc:     linux-wireless@vger.kernel.org,
        Aloka Dixit <quic_alokad@quicinc.com>
Date:   Thu, 19 Jan 2023 16:34:04 +0100
In-Reply-To: <1670006154-6092-3-git-send-email-quic_msinada@quicinc.com>
References: <1670006154-6092-1-git-send-email-quic_msinada@quicinc.com>
         <1670006154-6092-3-git-send-email-quic_msinada@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2022-12-02 at 10:35 -0800, Muna Sinada wrote:
>=20
> + * @ru_punct_bitmap: RU puncturing bitmap. Each bit represents a 20 MHz =
channel
> + *	with lowest bit corresponding to the lowest frequency. Bit set to 1
> + *	indicates that the channel is punctured, otherwise the channel is act=
ive
> + * @ru_punct_bitmap_supp_he: Indicates whether RU puncturing bitmap vali=
dation
> + *	should include OFDMA bitmaps.

Why _supp_he and not _supp_ofdma? Is it restricted to HE? What about
EHT?

I'm also not really sure what that kernel-doc means for the _supp_he
part?


Also this patch is basically empty - please squash appropriately.

johannes
