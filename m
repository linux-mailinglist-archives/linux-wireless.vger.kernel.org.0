Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32876FA2FB
	for <lists+linux-wireless@lfdr.de>; Mon,  8 May 2023 11:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbjEHJJf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 May 2023 05:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233507AbjEHJJe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 May 2023 05:09:34 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D63961B1
        for <linux-wireless@vger.kernel.org>; Mon,  8 May 2023 02:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=lXTCk8Hc3PLEYZvUgKJ1TRv+DM3zWEQAz+ClS0Epb4Q=;
        t=1683536973; x=1684746573; b=AFwlgApO1ujVT6Rieh3VRV9vtXl3osD71UGR7EnpLrlFAV0
        h4OR9IKXySBY0cEe8HRG/ob3QQaPWfUc5nAxIN8sWTaWiL+UmTf53/m3yxbDdn1rqsWr/msm00CXW
        QVpb3F5Fa8XVGkFCkBD4NfeakdazN/iBrgw4LgsXyG+4Ge9jJPgrIthW7u5zpGr6OnQMdG0HQUumD
        Hk8lLcYka464FkZUu75f6TLkQ6eftAkY8o+zcXIePGy/BuUsknzxcXgI6E+EZUNqH2SPg4T2kW81U
        F3h7fhYNulHIC8P8mdCn7pIa56QpZZghPvxWaoBsYkBT3H5sQE7/awskXtDbD5dA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pvws2-003Bfc-32;
        Mon, 08 May 2023 11:09:27 +0200
Message-ID: <ac4f115e7634a39d6b57fe9ec4838e8d72f70e75.camel@sipsolutions.net>
Subject: Re: RCU WARNING Splat from rtw8822bu
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pkshih <pkshih@realtek.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Mon, 08 May 2023 11:09:26 +0200
In-Reply-To: <d37638ad-27c8-e74e-ece1-c4de2eaccfa6@lwfinger.net>
References: <d37638ad-27c8-e74e-ece1-c4de2eaccfa6@lwfinger.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 2023-05-07 at 14:24 -0500, Larry Finger wrote:
> Hi,
>=20
> I got the following WARNING splat from rtw8822bu. Driver rtw89_8852be was=
=20
> loaded, but inactive. This is the only instance of this warning in my log=
s even=20
> though I have been testing this driver quite a lot.

It must've been connected at the time, but I guess the reason you only
saw it once is that it happens only on CSA:

> [18177.576760]  ieee80211_chswitch_work+0x95/0x170 [mac80211=20
> c276bd403dbb068b66ac9ffb0a8f27d6e63e5c7c]
>=20

johannes
