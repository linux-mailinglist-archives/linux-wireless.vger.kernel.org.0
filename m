Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D122833EF
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Oct 2020 12:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgJEKV2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Oct 2020 06:21:28 -0400
Received: from sonic305-20.consmr.mail.ne1.yahoo.com ([66.163.185.146]:38574
        "EHLO sonic305-20.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725887AbgJEKV2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Oct 2020 06:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1601893287; bh=ShrdGJTCUVMCJqYIFt8iS0epc16DuED8/NfeEkfRx3o=; h=Date:From:Reply-To:Subject:References:From:Subject; b=cMpp4mD6pPgxrtJFuEPf2VsTozMghnRS7p6EqdHw0UFiZJUkxsyBn6KzScbyaeSOwZBlha8ESDgPc9g91CBkQJiMtK71jjq9oDXrrLoBVO7iOPQUfM0uANCELTQXLsln3koDz9kYEFRBsbHbDVLcO9lKCqm/tFmXl0WlHjCpKBw87gMNO0Zv3AzuRD23vg876fHeIElwqsw2vVFd0hWrK3DgKLkjFd4vnLjPqANAatFMasCXMUcaGGKS6aeOIo5abwaOLWakeSoeiEK6VRTOxY4J2PPKV3eAay5eJU00g0bMi0kGNXUu+Eog8dfobTRYG4MM0yQdxwRfHlHaPUVawQ==
X-YMail-OSG: Nmhhkk4VM1mflldGy5KOVgMQY05SmEmn5286knUc2YGG9Ubo_pn2zjx4rT6ZxpP
 nWqRrqqu2XOJ3svju9VKq._HgB5b0hHJfblbN1GOqzRTk2mMdD5GZEZAJxkuZBw0Sjv1LIEflwfv
 laeeqXoMOUdh_XjT4rQBvPvAmMVtdm1XKnqoJlJVVqfpqCDglvR5b9HcZ8c7yvCMt2ROu44eC4cc
 W1oIzS8bEEwy1nNnlQz431UV5zVRGYVfXH7I03iyMmhCmRqMeCwitfH4pLCMSqxOpTQjKrunDESC
 Vb6UGK.MeuH6QoC8PO3776MROM7uDJXz0Rm1Q.xzgLdq6cOSXJcrA6OjDUkCqTUhvSMn2J5QDZhw
 9MChQVJ1wINI5N2FpFyVIKt7XFQwTvmqoBG4uzopSWwavoXWy8DUi9Y94WhbIvqW9sAKEIm3wjsB
 xkXQQi.oloFEFMtx4tAVLuOG8h5B8tumEJKmyOL.MnM2qa4QbYki1447aSAKbI3S3Qdq0UXczMqa
 OjILB2mrg7qJX8yaMyVbf1O2VodwX1bzi9TBAH0SDcYO0cgdeWVKPuhJOLXTU.rQbcpKy.XpFnll
 3YKn4BZSDKQlrsgyOVHaWaEcemb.Mjmu0fhtzi4QdSmfNbzNd_qlOf7itPtv6GdfZrYkyrya0eWT
 p7itVy0CvdfG3dFd6XBXJgf1EtRpiddAaDic4.OzFVyqQPBmgfE2OTU6s3r0JmhSJkB7w_W4LkWG
 KcpQkYiPDImV1wx2rchL.jAKaEK70kjf3tRPCnb8C3_txu1r0BQLkvNUzEyDUD7aAi4jKQu21adP
 x8MjHPk0K7vygpr9IKm6rbQwmEMztEWktPw5tri53RjT6xM8oy4l7YtpV_ShsQugs_7CBj7A8FbI
 Zr.5DhNrmncClAYmzt2o0bZoaVoW8ajaTcJFfyb9UOUdEt8HzcQEDh0GuCZqZsgWq0BbWGuhqBSI
 DsJsRhUoQggeUok74dDgvmjO_z.nzj6vbTyKzef3UBZGzeFfVDzWwidq5DyT.94xobMjsoIzWLl7
 utwyCjxRLEdD3JZt_yS2nXILN7B5glw_vz0I.5Hw7UgN4PhIixn1Al4y7FqP3bPUsy3lwDqAO2CX
 g1C2.wKD4SuQDXuyI6RbajQS1jJamUoRHh_fue_FpvQ2pgHwrdy4vTmQ6tXWm.lGn8nb01K8FqTe
 la5elwhQVn_sSkqNVqzdGHS8iSNBQD8V6vxyqNlbTKEWMfnYZ4ysq6YyVLMdPrwIE.zxC.hn8Dzy
 E5oU1K96An3PpTCxt6uKwYA5K351aoiTGAMeYOr5msbg62hNMwI_3ZjrIVVUV7yWpgRIJAs0lOA3
 VRSPGsfDXmY6oxgjcbw9wamhQRI98ZcQ3Q6M0kI7mTpws.FeleZhaxl6YF1uFXx_NUFec135rXyF
 1p4qWl0hwllSohmN0vnJqOYqyjhfj0_HWOZyVqM7kNPHP4sQq
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Mon, 5 Oct 2020 10:21:27 +0000
Date:   Mon, 5 Oct 2020 10:21:25 +0000 (UTC)
From:   Ali Shareef Al-Emadi <alishareefalemadi465@gmail.com>
Reply-To: alishareefalemadi465@gmail.com
Message-ID: <776347102.1962196.1601893285122@mail.yahoo.com>
Subject: SORRY FOR INTRODUCING INTO YOUR PRIVACY
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <776347102.1962196.1601893285122.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16718 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:81.0) Gecko/20100101 Firefox/81.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



Greetings.

I am Mr. H.E. Ali Shareef Al-Emadi, Finance and Account, Qatar Petroleum. I have $30m for Investment. Contact me if you are interested; I have all it will take to move the fund to any of your account designate as a Contract Fund to avoid every query by the authority in your Country.

I sent this message from my private Email; I will give you more details through my official
Email upon the receipt of your response to prove myself and office to
you.

Email Address: alishareefalemadi465@gmail.com

Regards.

Mr. H.E. Ali Shareef Al-Emadi,
Minister Of Finance.
Qatar Petroleum
