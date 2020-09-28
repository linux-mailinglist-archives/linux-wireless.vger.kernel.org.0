Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5D927ADB0
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Sep 2020 14:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgI1MZA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Sep 2020 08:25:00 -0400
Received: from sonic306-20.consmr.mail.ne1.yahoo.com ([66.163.189.82]:46254
        "EHLO sonic306-20.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726526AbgI1MZA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Sep 2020 08:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1601295899; bh=CJfHRA3PAxA/lp6Mz2SeiBBl59bd5y646SzWk6cUNN4=; h=Date:From:Reply-To:Subject:References:From:Subject; b=TOsasdNyhv5GJjimDWwLrZa1sL7tcEQO1yah3JjAR5iyjJ1dfwt0aXRiagM9XjAINI8Exj3MNBbtSuTZT70UWTXmZNMTf+vzNuE5acIn2Gc3oaUwfJpGFyHfmBfw70dzSGLBtYQ1d84VtM488LIMwU6ncCkjtKJFLwe41VZn7jUQSyMIA3UAmTU0VPo4vZdGSyTFlLk30bzM9v4egvMPcZFFGJchwmZGT5iMrq+wYfMB8J/OIWZfYr94vpiKFp/Ut1qL51y/qYLAcSpl/aMllYLDICvebRF/BNKa/nj4bbm/AXt6aX3T02Apcx2C5S4I9p4LUfHmW/MO4OyTlcypmA==
X-YMail-OSG: Z1Ju0M0VM1kKT_Y8f8D9yhdDDSfXr7Xwe5CmHC.s8AFs5wL6LGxabylazsytwcn
 1xrfXjmmbbyT0nDDhpOuJ5L2ELIzJx9kcuAAsMXUNuw1ogzsDmuJ800H.9SfKal5isYIl324jE2M
 UeVQ7imL4eOJwRvnQ4CmdoDqfv_kmTfPTHJAjgD_0sMBEhSOHz5rBFgg2ewn8iknxaKoUpIIak5T
 FY1_a..9XDhM_FzZysxx7A91y_qwv1gd3xktDS_zdUqIBkP8bc6hDm1AMVvVW0Pnj_O3qzDJ8XPT
 zPFsDRIi5PTRyTA0S87gsxZ29WeMKl3cqkilhPQrP28293bHHRPNmdm8YPIfkb0Q_wm1K0HjJXbh
 SBSaY6Yhe6RyvqGJeZ_GEJYNL3lwvSHiw70kNkecIBsmGkDsN.arUind1eLV3.sH.aSssI.5i7SL
 rzmBFNdoAlcH1Hc3UjRFSuBnfWtC.EAOscpmyEdoaLhQbPIlpGikd7FgkHDVrm_36kghX.q2USIH
 4FCfkw0cfF6ZXrzl.oYYXpSfTdKYn8Si5KqF2Z25hhdOjFZJ6oYoGMS3rbmqDRGSTXmAd6Gwrac5
 yS4ntUlHKComqkSTPE9u7zrQfuOGqpj8GoyKSxmaSoRr8DsD7Ij8JvwksLezNmOMQokfT8tiCye7
 rTmsBj8GtfJtRCMcXCs2.l7G22nSm91b9xG.53NsfJhh83vhknyy8OjvgdetU4_uE9rhQXzKieLU
 cvQ3QFotdlfrCAG3M4c4uvVMBMWsd9Ls7Ko.ue1xstAZd6ESwLc1JwiObEFnLx.RcSFIAUgi0zM5
 Jfs96hrxOp7XdPo0UH8lF5Yo4pqmBv_uSk4cxh9tkrXVBoptD3vFjhpLyboHf2YN9d.GPK9EUtpZ
 zWZNeYhkWlHa4JZGH__EzxKdM7SXi5uBV3P7jdFd9nnjaTyS2Hat4SU8JkDmrRFWPVrIMMmdIGBP
 klbYKv.C0KwcK2MrPJHVLdVwSppbbkyW.hegWqgKDfte.0IvzEXbcHAWLGTLWB2P8GRBlDftkOsn
 CQz7Iu2c6uPIwMdJ0IXA600.Na33TTqPTDZhE8ldg8p1t4rBpq7IPc0lrJBlOMtOMxvugVPc1YCs
 MGoQQY9KaOGM8kCqVLduZyVxHptJexGqKr.3RJkdVYai45RX10wUVzMid0c5hUHQb89SAhHJGZQ0
 77beZHASCjGYpblwStOHkIkbfTnsqkYz1vCqW.9rm7tR5Kxc7x3tDOh_e69TB6.3MM2mf5Q3oCsw
 zsAHTWU62z8JvHnF74S.4UOUNd4ugNizPzHVzTowZPs1mXjDYtJs2JEjnOAgu6udpdMg9wG0.WEM
 0ro50g3XfM7TjqKE5UWjj5jy1DXRrgEd.Ld.ACsSR4g22_WVWAOnLE8NfQS8MRunHXbnG.5oUVHn
 uU4SWDr9FLNB508tPvXPeO4Wh8JIAzdCgx61AvP1dpxwu_87up9s-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Mon, 28 Sep 2020 12:24:59 +0000
Date:   Mon, 28 Sep 2020 12:24:54 +0000 (UTC)
From:   Tapsoba Ahmed <chikabarnabas@gmail.com>
Reply-To: tapsobaahmed100@gmail.com
Message-ID: <925251784.1516160.1601295894474@mail.yahoo.com>
Subject: I NEED YOUR URGENT RESPOND PLEASE
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <925251784.1516160.1601295894474.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16674 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.102 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Dear Friend,

My name is Mr.Tapsoba Ahmed. I have decided to seek a confidential co-operation  with you in the execution of the deal described here-under for our both  mutual benefit and I hope you will keep it a top secret because of the nature  of the transaction, During the course of our bank year auditing, I discovered  an unclaimed/abandoned fund, sum total of {US$19.3 Million United State  Dollars} in the bank account that belongs to a Saudi Arabia businessman Who unfortunately lost his life and entire family in a Motor Accident.

Now our bank has been waiting for any of the relatives to come-up for the claim but nobody has done that. I personally has been unsuccessful in locating any of the relatives, now, I sincerely seek your consent to present you as the next of kin / Will Beneficiary to the deceased so that the proceeds of this account valued at {US$19.3 Million United State Dollars} can be paid to you, which we will share in these percentages ratio, 60% to me and 40% to you. All I request is your utmost sincere co-operation; trust and maximum confidentiality to achieve this project successfully. I have carefully mapped out the moralities for execution of this transaction under a legitimate arrangement to protect you from any breach of the law both in your country and here in Burkina Faso when the fund is being transferred to your bank account.

I will have to provide all the relevant document that will be requested to indicate that you are the rightful beneficiary of this legacy and our bank will release the fund to you without any further delay, upon your consideration and acceptance of this offer, please send me the following information as stated below so we can proceed and get this fund transferred to your designated bank account immediately.

-Your Full Name:
-Your Contact Address:
-Your direct Mobile telephone Number:
-Your Date of Birth:
-Your occupation:

I await your swift response and re-assurance.

Best regards,
Mr.Tapsoba Ahmed.

