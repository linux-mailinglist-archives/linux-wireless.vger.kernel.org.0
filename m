Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3FD3188365
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2020 13:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgCQMMH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Mar 2020 08:12:07 -0400
Received: from sonic308-2.consmr.mail.ne1.yahoo.com ([66.163.187.121]:45990
        "EHLO sonic308-2.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726980AbgCQMMH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Mar 2020 08:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1584447126; bh=kcevCRoll2+Bsa3FDERpIV72LVcB1A4YV1b5N2AWYBk=; h=Date:From:Reply-To:Subject:References:From:Subject; b=NYCb94fS3wzfRKtWy644HTesSI8IjQzMsblWFpJTYYXuTt9rcUHt18ZgVioI/NXet/fY8SAq+fAhZC5iqfT8mOYocM5nxjEixe6V2WdNJfQIZyX+6jE5K+as7CrfQ+Ux7bmM2apeIjzkOXtI9thNL7+t6aATp9VCAaucXVpdqA4dR3OLsia/qo8V/NSozfuIgHc+phEYPjPwuFiaUR8KfKEUSr8lLpfJQAGCw0aT4SuF8jk08cR1b4zNwwDV0Ri9Xp3/TXYmLnYONGhUCRynHw6WHZMJ+aV7unuLpNZHznI8c2dWULGaYJuDwHlDMukb1L6U+i3bCeM+cRtgNwsmZA==
X-YMail-OSG: khjlJNIVM1lQSvc20NlSV_u2jnd0qmE3gUZVQrpYE7ugpBlTzmdoWAmydHLsjOn
 v35WtMF5S5Z6e2xLPAqmOWE5bXZaWj1.2fxcoKt.f426tAE6xmfAxkfWB1oc766TO5Mf.whmqQhy
 H3VC_3oXasMfp46r0fLG.ynQ.smEEO2DnWdBAdTCj1._0gyehQYQtvG4djT22x5nNY1RpGhCnyLh
 X3cGTsriGS5gQti5UQXYc8C.GhxXCQOkmUhsIrcp4IF7i9xhpcoEUbKYO4mm5MtfzA37o5gSa3Nc
 9x9_4Bz5olQxo3ej.IBY3Rjl8H_V.sY1OC.olnUFOe_GETcbxS_feutVR.bF_l3tPTTPlIdyhs9I
 Md8I9Btml1_N6de8csgr5YKBiKap43gRW272lKNKoRyuHOEOj.iYditEiEosSYzE.5nepb90AScU
 ba1lCnXYoecsSLSmL4J9ZKCnR9mIhLA4_KpTKCCPUCRtf2JN7nrJHdnSZm_B1jGsOhILSMsYvG2Q
 .XwzlgF6RAZu.JfzGT8gKvQlkfxXL4sna0a9BT.25cKJTpu1fY8qOJ092YQ9sT4UkWhMD.93gIQo
 ifVVIWYh8rrYXPXALyevhZgJrjrGIVDBvBFa_CkbKdL5elpxmMUXN8yGslledahAQVBiaRTEfmlN
 1A12U6Rad5dIs1bSMTHbcXMcZPqA3o1jTKIGCaLyw.N.otbiUhOSNyX59ozCJ1TeuVtNbg4rZgfl
 6sLWDx0AdjLkcx7Ru9qh3A82_qVjlWO6lh8WyT4V_fX3qLl2LDmx_EndcCk2VyKvbb.7tITTWVMm
 Fi0ovw4DRxSwI_Lz5mMe25AY1vf5MZOo.W9yPjT6Fb8bpQN4Ct2ZYwnoff9RMvIdLdz6LLQ2eQoF
 mTb5ep8lclN9Tr4zMyc1FGXtX7.0lNGOKuTri1V9Rch8iKjupTGiGqjdBavSot4MC80w99BP6g93
 _XPpOp1ooow.GcLgdgoBXDqBOikUI0Fjw1F7pXbeYVMzFPBY.FmuU5HGphAbomZipXfNRZII6YJM
 CDGTYacPmFjGxL_rSDrmzpfinRWDTRgcIfgldo6TNDW2z8Vv9bfNKOxEpaY_Iv2NcGRFUM0ODrds
 _oumWGAGcl6HB92B_dqhzlXVkAFW2WLPFtVpzLpSKgwC5QtKM97Mck19wZT6qdlsxKhXbAS5cgx.
 2eZKcVPeklXBZDF0AHzZSaTXIhTA2fZezsg2KQBnr36WQ32Hqqh6Pbb9_Mk5D8yoGC2VfbhMuX_S
 zTMQFTY_lac1F0MdlLOXdBlhuaJyuV7b.oczGGGq8mM2tDt5s6zNxsxqpqz0azNJ3sHoDeLpThuP
 W_hp5fbuo0WSAU_zIA445LehoVxmXclWg
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 17 Mar 2020 12:12:06 +0000
Date:   Tue, 17 Mar 2020 12:10:05 +0000 (UTC)
From:   Stephen Li <stenn6@gabg.net>
Reply-To: stephli947701@gmail.com
Message-ID: <1707692409.1824590.1584447005739@mail.yahoo.com>
Subject: REF
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1707692409.1824590.1584447005739.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15342 YMailNodin Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



Greetings,
I was searching through a local business directory when I found your
profile. I am Soliciting On-Behalf of my private client who is
interested in having a serious business investment in your country. If
you have a valid business, investment or project he can invest
back to me for more details. Your swift response is highly needed.
Sincerely
Stephen Li
Please response back to me with is my private email below for more details
stephli947701@gmail.com
