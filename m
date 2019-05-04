Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA6613B73
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2019 19:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfEDRkd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 May 2019 13:40:33 -0400
Received: from sonic314-53.consmr.mail.ne1.yahoo.com ([66.163.189.179]:34706
        "EHLO sonic314-53.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726693AbfEDRkc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 May 2019 13:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1556991631; bh=Wn45IEVQxjYS/KJ/AenupJ6pixj3tpnk+IQw8lNF8Cw=; h=Date:From:Reply-To:Subject:References:From:Subject; b=rey+bWihNw74pAszG8aLNkWR0kM5/OjWZQGHJZutD1bkvNoS0oENPYrtMfsqAILP73ixYWcJvdtoSr6NZOQULnR4VRa8DeiSYNSPhGplBLE3VZrLz6QeOTO0uG95YD1Jh+YZP3JQeaUw6ili+PxQ8glG1GMlK4yRQ1YZcDuEkAVd0EyX25hjhsrU95+90TNido9umRrPAHGc0epPOf1puz584LoTgmvmM5sMdjs2+sJFT/TZ5ztDXSeZ15ZtuVT6PuyBy9L5xlkwCsFS+mzodbcihy8U64ZG46JHQBJKXupZ6DO/bWozkjC9revIPDY/yOYpEmc7kIegGCYy+n1mHw==
X-YMail-OSG: 39RWrvUVM1lI0t7v_kMAKEiqK8xDvxJJqJNjKxwZTcMmp7TAwp4zY3YmT.1A3Pm
 zMig1Mm.SPfOklkpwX6e8gGKhzuY5taMtiUnsK5JAjXxt2x2tKjauwZ.ZSYxa.YPoDBbMQjy5eqw
 r.PsrHMpWRlGFcEqg9o71cbscV9cDijxizh_wVdb6Ix0k.mMhQVOKXH5GyA95vc0W7smTVJBh96x
 ZOsV3UucvxFO4n3jr8rRdkO_yAdlZKH6wvN0XfcbDFvTuwu.pF9zNnHqITzGV8cV6Jra0OJFuP4U
 QEFXeIu.bLh.9_6TeMHsiSIBD9SeR3KvFzQXw7pXf50Drl7z.tXtnSCpAckoh_WysFjvecIs4bJJ
 lCjs3OkVcNfVtFo.HbFc2VgKekz_2WDiVA4L1Z.iIRhqtkU2W_hlsLdXvj96HfXp.YXggD9zugzR
 dCDrnl_b1pPsXFaL4a3TE_O9snzq_t4E7g4mQalBjGDH_CxIcHdbwk5MMHQ.xliABM3MrVI3Dggp
 BzaVFB5FGb4LODie3T75Q1Zzm6MUpZZXyoesU_l7tnTBwnlTMccUisQK50BKjrUSCkQ9a3pc0fJY
 xP.8ZsLKGOcEoEdnXvoAyTBn17XnFOGlnFnY.VyCbK.OO2G147AcAQCjk8dTSnNpkltpEI6L1wwr
 xvI1lWSKjBFbkk7wmc6TVypZClThb3NmngtmZmqbEEUiqQkVnyCZJq6Klz_YfzzrCj3SBJmXv4K4
 _LYFauYpcL4pyyEJLDKsibehem1S4_h.MUIoCjwqtSSF6mLfC7c1f8a4ggnFqNSVCPP.4AJcYqBf
 ah5Eo6d5ND2Eua7250NfS.H3S4tae35heXqmCowqNXob._Ioye3Qbkv.pkbpE7_6PKbimK8RSjtM
 si9NwTt53WXS._br_EGm3.bHyt5Vtbs.GoocbuYsAVzf5RVQc_tNRdUSjM1HhYRkGIm.mIzNW8Db
 zVOYFpgrOJF.59wD1oXopBIO2zveovbxqEicOerR4LiMufN23WRRf2j5sbtnsCBDoxV5DoCjyusZ
 BhZweuWqVQfjI5DhdKGTvk50vXiQwS4TPmhaRRnshZ7WNtxKgIoKXidevHzFWZO8CdCKPL_s0qlw
 959scia6B8crHGV4ni2lgULtlAafh0LqSlnZcp1b7KGSLS99Rd5XTBex795LQmiA6AJsYE2QsUrV
 ATtTxVwYxuFabAl1s9JUu3pDhIAbPdUPavImcPyEa9B4sFgB0MiEYytBiVj0dBpk-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Sat, 4 May 2019 17:40:31 +0000
Date:   Sat, 4 May 2019 17:38:30 +0000 (UTC)
From:   Major Dennis Hornbeck <ab49@btopmt.online>
Reply-To: Major Dennis Hornbeck <hornbeckmajordennis635@gmail.com>
Message-ID: <1930395256.1373343.1556991510360@mail.yahoo.com>
Subject: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1930395256.1373343.1556991510360.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.13583 YahooMailBasic Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.86 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I am in the military unit here in Afghanistan, we have some amount of funds that we want to move out of the country. My partners and I need a good partner someone we can trust. It is risk free and legal. Reply to this email: hornbeckmajordennis635@gmail.com

Regards,
Major Dennis Hornbeck.
