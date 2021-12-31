Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8CF482548
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Dec 2021 18:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhLaRNE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Dec 2021 12:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhLaRNB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Dec 2021 12:13:01 -0500
X-Greylist: delayed 319 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 31 Dec 2021 09:13:01 PST
Received: from mout0.freenet.de (mout0.freenet.de [IPv6:2001:748:100:40::2:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202CDC061574
        for <linux-wireless@vger.kernel.org>; Fri, 31 Dec 2021 09:13:01 -0800 (PST)
Received: from [195.4.92.122] (helo=sub3.freenet.de)
        by mout0.freenet.de with esmtpa (ID andihartmann@freenet.de) (port 25) (Exim 4.92 #3)
        id 1n3LNS-0008QU-LS
        for linux-wireless@vger.kernel.org; Fri, 31 Dec 2021 18:07:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=justmail.de
        ; s=mjaymdexmjqk; h=Subject:From:To:MIME-Version:Date:Message-ID:Content-Type
        :Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Xlzrxh7JQtps10BW+uGVvWVsROhshMlEtOPmlYrwQzk=; b=dcMxXfBsN1bu+jGUHbPmtCxYFq
        IeyX7Ykr3vpqobqDtV9xuN4+eUdRxGBNvm8nKCODax0OZH8VRIyouxQV10ti+mdMDENplxu2i81i9
        c0rUeHyenPdx4Va+UmAcgedHdj0FqrbBUp4RII1AmnBgXfw3BfGLCKO7ozLrP1/TdmTUrEN6+5bK8
        VCNlW+3mWPRh0CADhS/nJF3bBG+VrsSs/jtoSLAyQ9IxYzOySKMOysVInrFd1jxX3iCVTXK+STPZm
        7KT7CuSj2tqg4AktQnRBesIfZhjZoCebeB21gAQyr5f0YmakLKBg7Wxzc5QsDDEQQKlMIKS9VR+X6
        wlX1Nsag==;
Received: from p200300de574ba600505400fffe15ac42.dip0.t-ipconnect.de ([2003:de:574b:a600:5054:ff:fe15:ac42]:50152 helo=mail.maya.org)
        by sub3.freenet.de with esmtpsa (ID andihartmann@freenet.de) (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (port 465) (Exim 4.92 #3)
        id 1n3LNS-0003b7-Iy
        for linux-wireless@vger.kernel.org; Fri, 31 Dec 2021 18:07:38 +0100
Received: internal info suppressed
Content-Type: multipart/mixed; boundary="------------t30KFMvVduofS9dWVYW250tm"
Message-ID: <bf74cccd-92f9-c09d-b29c-53b126a5ae88@justmail.de>
Date:   Fri, 31 Dec 2021 18:07:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Klaus Mueller <kmueller@justmail.de>
Subject: rtw88 (https://github.com/lwfinger/rtw88) / compile error since 5.15?
X-Originated-At: 2003:de:574b:a600:5054:ff:fe15:ac42!50152
X-FNSign: v=2 s=7084C6090B58D86AB622A53E521E57AC7E6A5860AB80213B51406D4D6E687AA5
X-Scan-TS: Fri, 31 Dec 2021 18:07:38 +0100
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a multi-part message in MIME format.
--------------t30KFMvVduofS9dWVYW250tm
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I found an error compiling rtw88 w/ kernel 5.15(.12). The attached short patch fixes it (works for me). Could you please apply a better patch?


Thanks
Klaus

--------------t30KFMvVduofS9dWVYW250tm
Content-Type: text/x-patch; charset=UTF-8; name="rtw88_mac80211.c.diff"
Content-Disposition: attachment; filename="rtw88_mac80211.c.diff"
Content-Transfer-Encoding: base64

LS0tIG1hYzgwMjExLmMub3JpZwkyMDIxLTA1LTI2IDIyOjAzOjE4LjYzNjAwMzQ2OSArMDIw
MAorKysgbWFjODAyMTEuYwkyMDIxLTEyLTMxIDE1OjIxOjAxLjI0Mzg5NjUyNiArMDEwMApA
QCAtNjU1LDEzICs2NTUsMTQgQEAKIAltdXRleF91bmxvY2soJnJ0d2Rldi0+bXV0ZXgpOwog
fQogCi0jaWYgTElOVVhfVkVSU0lPTl9DT0RFID49IEtFUk5FTF9WRVJTSU9OKDQsIDE4LCAw
KQorI2lmIExJTlVYX1ZFUlNJT05fQ09ERSA+PSBLRVJORUxfVkVSU0lPTig1LCAxNSwgMCkK
IHN0YXRpYyB2b2lkIHJ0d19vcHNfbWdkX3ByZXBhcmVfdHgoc3RydWN0IGllZWU4MDIxMV9o
dyAqaHcsCiAJCQkJICAgc3RydWN0IGllZWU4MDIxMV92aWYgKnZpZiwKLQkJCQkgICB1MTYg
ZHVyYXRpb24pCisJCQkJICAgc3RydWN0IGllZWU4MDIxMV9wcmVwX3R4X2luZm8gKmluZm8p
CiAjZWxzZQogc3RhdGljIHZvaWQgcnR3X29wc19tZ2RfcHJlcGFyZV90eChzdHJ1Y3QgaWVl
ZTgwMjExX2h3ICpodywKLQkJCQkgICBzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAqdmlmKQorCQkJ
CSAgIHN0cnVjdCBpZWVlODAyMTFfdmlmICp2aWYsCisJCQkJICAgdTE2IGR1cmF0aW9uKQog
I2VuZGlmCiB7CiAJc3RydWN0IHJ0d19kZXYgKnJ0d2RldiA9IGh3LT5wcml2Owo=

--------------t30KFMvVduofS9dWVYW250tm--
