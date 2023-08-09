Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1CF775EAB
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Aug 2023 14:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjHIMRM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Aug 2023 08:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjHIMRL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Aug 2023 08:17:11 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7AA1BF7
        for <linux-wireless@vger.kernel.org>; Wed,  9 Aug 2023 05:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=MGGpzWy7VBccB+8l3MXRUdWJN8M9OwEXxLhwnlMbWNQ=;
        t=1691583430; x=1692793030; b=Xmqjc5fGOBpgo5ssZDvGveF2unmpGDbjy9DS2K3kHwXgCla
        j8cNGIh69BIQUi/pXdz/5fZPvupbSK37XTAjyYMK8azyfGiAeQpok/L1Ra12NaKHSA46TmoC5tnH9
        8Uh4Q6pDGsjxgDdeqQirCEenBcy2UYHHMiKMLgnsb2MBNyUmkJ69BVhXpgkSzlwrtKM5G/+SXRfO2
        1BRJaISWFS9xkGD6/XsKBipRIQ9NtaDIyop5t25SVaiPnf4T6vuB14crgpUKD794s7BFl9Oe8S4jy
        M4/PfzH0kuvCnYnR/NUwkUt3ddxHn9kf8JdER5mDUuTPhDVKzD4Ve5i3Ij3cCMXQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qTi7b-00EcXr-1I;
        Wed, 09 Aug 2023 14:17:03 +0200
Message-ID: <5cabcc57acd781e90c35fcc9b3c6a8aa8fbaa581.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] wifi: ath12k: fix undefined behavior with __fls in
 dp
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Harshitha Prem <quic_hprem@quicinc.com>, ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 09 Aug 2023 14:17:01 +0200
In-Reply-To: <20230809042738.13394-3-quic_hprem@quicinc.com>
References: <20230809042738.13394-1-quic_hprem@quicinc.com>
         <20230809042738.13394-3-quic_hprem@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2023-08-09 at 09:57 +0530, Harshitha Prem wrote:
>=20
> During the crash, the fragment id of that packet was 0 and
> __fls returned a junk value. Hence, it was identified that "__fls"
> would have an undefined behavior if the argument is passed as "0".
> Therefore, add changes to handle the same.

Umm. That makes it sound like you are surprised by this behaviour of
__fls() and expected something else?! Please go read the documentation,
and then rewrite the commit message. You really shouldn't be surprised
by this.

johannes
