Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDB3D19EBE0
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Apr 2020 16:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgDEOI0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Apr 2020 10:08:26 -0400
Received: from sonic308-1.consmr.mail.bf2.yahoo.com ([74.6.130.40]:43207 "EHLO
        sonic308-1.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726410AbgDEOI0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Apr 2020 10:08:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1586095705; bh=2Dix5zmYCHo7bbPznkkiDaMe3tSczOhwhyldZGWZBns=; h=Date:From:Reply-To:Subject:References:From:Subject; b=PX2YYKKygjnm3DnGq4u28wDKKi3Q3dp5jdKPeK6AwFHyhTsdmvbDwOwiVbwEzafgPiNrjyjvjfLSJWpULdQ+QYZCYp3JXRGPYA3VRbCkelUt25RJiJL4BwXquIa3Fyp7KEMipvQtM0mUKOJPQK7a0HJ5+7yOBxlJFDbeKxBuemWx8FRqfU1T/8BxwIPysUxSuxjE5Z9ljQQLGF0oZkmqubZw1q7SR3fVKVb10LkQx7KhMuezQ1aOXFgJAwMXnkR0oxvPylSauIq37ruC3fbbBeznftoC0NgV4/lheChoO8r1n+L2vOf+zyIrCesXuxem2Xa2WWSZ8zrSd8bTjVPTug==
X-YMail-OSG: qrBN5IYVM1l26QmvRUicIKmfjSCJSigQMtOZgTV1WcvDw8WbMNyZ7tj.4_J6oTo
 DkWhSUqcFX55wmoVruT7KClf767XG6L4YFMRmKu0103y4O6mudtDGxbrDnILlB5jd_z14ORdHUJJ
 S3Cog2LNRf68vpph1jcJzA.oKyyGE_qmyzKQ46wIDHDUpZlBe_4olSxzwLENS_dEJcp53h7J6re4
 Durnssmokfwt5lq3EGRXs_oJtlUkpYVhUdS0yEFZ8nSP.VRFBwKX1HOQzluX1fsykcp4qwH2vtJs
 .giZ1jUEEm7MDHkbywDC4ZjEnAjFAwmMc2BLVjgR3EYRvelbU4J.zGp5B2uH.mgi_mHIMyo1IxNj
 NLgdq8J4kuZr7JmbDYw3DBSrs0ZrUdkIHFTH.zrzZ.P1nKgBcYDKpc8kHn9aQkvy1Dy0nIZrRO8s
 pDGcGRQpvlYrCgIluAbaWrChaFLoUtBllCRTRjDIJixVJDJrYHTrJvliq9qAN9qFuKA15yREZD_r
 2mZtWjkDU2ChVj9xt.fT72FmZ2wY2eTVPzAj7Lm5ZNbutQjny49UdX24i4kba17fOKjf6o6_kJQN
 UX392Jygtf4a6LiOF6F6TbZNM57LEudnWA0xTSSkCpfND2MJCZKJbmCE0c12RELeXZCMvl.j6cKW
 J71_qRs6uI3DzePRcaPu4BABliG0jBc88qknmzgH.MrKoiO5YkVQ0rrP.poCULERqLXVgkVcgrmc
 nt5Fd36laXAPzpx1k_LTp1smtHFlmxOf0LuEXjTrfYvJsFTRGtdwYuoMWoa5xSakeUsPwMWDtYDJ
 0W9EeE.gb12LshArdP4XODCvaQf3LIlzBWdFU3whqUyHdNi.A_5SwrwDVB_ACCNdXVtUdjFjoTEO
 QAJ.nxVEtLkaBp_qkDW4N70ux_P37d8SGj0fyp8yna7iRIz622RMIzQpVYWOXl78QBxxp6G_6PSz
 vLVrha8aVux.GSO5pr_SShtrT979enrzipikrS_KZ4OUvGq6PAvTvzXaQjszEsPzMyctrZ7n7.ul
 EgsnOq7Uc9k0ibrOYv6gi7hf2mRyfVuKK9gpau_u_wVvC0fWErNBs40eBQsAKUxqIZSLICDfXyU2
 oaHbBlwWexUBvq.O2gPDjJfCBGCL0PsOglEqE66shXr7.ll4XMPQL58N4lrjRY5O__toiqRu_IHA
 G5oh714jRaONQr4drApLGq_wuVBb1OHoT7wDBOqZ6oAf8RxgFeiqSLPugGCr3ZPkgVgt0vujJfbS
 2SCkeypVX.0xD9PlQFQ8ibCenRGl8K9At2We22.0onkwyn80Yqr4djXRM0ARLXDBLYCBER0U-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Sun, 5 Apr 2020 14:08:25 +0000
Date:   Sun, 5 Apr 2020 14:08:21 +0000 (UTC)
From:   Sgt Pamela Render <sgtpamelarender@aol.com>
Reply-To: sgtpamelarender@aol.com
Message-ID: <1050555750.551889.1586095701985@mail.yahoo.com>
Subject: Nice to meet you
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1050555750.551889.1586095701985.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15620 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.163 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org





Nice to meet you


With warm heart, I offer my friendship and greetings, I hope this message meet you in good time. However, My names is Ms. Pamela Render 33 years old female . I am a serving US Army Sgt, I have sent you mail twice but you never replied any of them. I humbly ask that you reply this message, to enable me disclose the reason I have been trying to reach out to you. I do apologize for infringing on your privacy.

Greetings from Sgt Pamela Render.







_________________________________
Sent from United Nations Wireless Device Server======================
