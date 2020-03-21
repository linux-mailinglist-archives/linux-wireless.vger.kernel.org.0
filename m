Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 932CF18DF05
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2020 10:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgCUJTV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Mar 2020 05:19:21 -0400
Received: from sonic308-2.consmr.mail.ne1.yahoo.com ([66.163.187.121]:35894
        "EHLO sonic308-2.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726947AbgCUJTU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Mar 2020 05:19:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1584782359; bh=kcevCRoll2+Bsa3FDERpIV72LVcB1A4YV1b5N2AWYBk=; h=Date:From:Reply-To:Subject:References:From:Subject; b=D1cqfHLTvndZoHUSlt8UNtMkbQDtPD8E3ls63EQTGvxhHOlS06LlXrtHABIRSZ13mPML0mTPQdDymRm9ORcBd3/ugtQ562nGKPpC2aqegZW/rqKqLHVOW0Ak+A6Vv1/vKGCmszUVhornqS2pr0ZKe6YFaFeYW4dTkydmwXJx85nAXz4wehbcsq4AcXtPvQ/Ge2dKZQskVdMUXuGyxK49QtBrbpeR8ZJL5Jgte1TEF/JA3y6W59NohvwP7h6kxXEWfSd7dPOV7ZFxek1yQ6zibwaEJOQzuWNwbSLPlcl+8t3CWeyu83MbvPXhCTGMpguDvB3TClOuCvLzPPR51Av5Pw==
X-YMail-OSG: IR7tbfoVM1nZbDeU0qA_jNaYC1822WH45_SsvzmLCWyWC44UPNmDOPOy4TTpVAE
 dIjzSf5B95HVmoyRDkT3s_CXxyT9G4R.UEcYPVMTNh63I2cYH1J64Ka2L2LlYbFHLEULr2duHeXA
 fZAe.JTZK6Uk7pJnYxZXZH3Gbl..WIG5j6B5Cn1pmUbPcpmtsXl3acGLT7qWRToszomsyiz5uIu8
 aHsF4qzrrw1auMaMkU5LV3bOSTESajCXIzE0x6hyEz0QjYh.wgroAJlOlkYbKFz5e2WugFuDljTw
 Qy2sqT0sJky0pedTm7OfQ_z26Dc9DLYBORRSC62lSDtPFBy.q5hNqdQQjNkSt9SxG5G0NWN.HWTY
 _s9b3OKg_D4UHZY50dtSKkSR8Yoc7BT42QvGzMRlsF57xefdTbEwhb55MB08lSxzis9GfEf7kr6v
 k_P0qD9Yr7cyhgC7Syw.DANmdEDHixUG4fX7ZV3AsucuGi_hS0zgy.cQI_9L_Fc1OVhCZ6jchGWf
 Ywwpzb2j99IkhBpnyuTinhb0oZudxLEM5Ml.0KwcP0szHq_YUKdc9db3NeyU3RM5fA4QMxeoTJQv
 Km7s.hqKx1QVWZBK_gul2zGMv1ddPBUCvbiKn7Ik9rg4Nf.R9.lL62fFO4wKXqdl0SP8lDsy614h
 fJ0VRRTratu66td6lDZjLAhQYHOFvShyYz61DdqFNP4BnelfKwaEMNrbkt3t8S3PfTXaIIOB8.Zw
 X2qaMS.HLv9GY0vjcwwE87hOcj3ds96MXEs3.0VbJAeNXt5U1QKPLTwr0EkX8A73XU._R1q99JT1
 CoUWo1oC_s_cmNiCce9VBY81sLXv61pbLgHEcHsPIOT9efajFf32l2jPtBAO1gBScgz1cnfPbrPV
 4PBhXh3WvLrWWXDH8csHCXFIJJW5uTrvin5X6hQ5C3AbSqbzYB7EmkuwaTW8x57qQF6X82SY0AXF
 _4MyTd5P.I9D_Kuh8VXwRW6ZG2eRhRCY3zFNbMB6o2g5q3.cwKaCQtb78Xhhql.MEZgE3Ysh584F
 omo_cDFnvRYJIN5eLafcWs6aiQPDw6gJdJO4jhuIK_5DPMfbvITk2Q3XcIvLG7AVQf0iysUdOSYI
 Xrtdv36ui3hn3ZkSokHaIhImc5mFdH2_uX41D7i9HJqwJ9WzRmq280Z_yNA7.C6HP..q5bUTDWi9
 OCwKE0YIhslYjT7jxSjZPBB9CmQNIcMGM4IAcnCS5.XHWx1huaVYNjkxHY6m0HqpNHjc0O2XKlhs
 fjRq4ZPuXjypf.ZvOknynAVM.Cjg9AV36X_hXyi3PkkNtNLHnkSx_XkhGXFK6_VueCpx_EGadbdl
 X8Q..AauUzT7veNWbrRDkCSVW24DjpE_VDfof5YnEDX.MJnCpIJOscWTu
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Sat, 21 Mar 2020 09:19:19 +0000
Date:   Sat, 21 Mar 2020 09:17:18 +0000 (UTC)
From:   Stephen Li <lii77@kcgut.com>
Reply-To: stephli947701@gmail.com
Message-ID: <42031118.74631.1584782238062@mail.yahoo.com>
Subject: REF
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <42031118.74631.1584782238062.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15511 YMailNodin Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36
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
