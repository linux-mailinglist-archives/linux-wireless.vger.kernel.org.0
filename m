Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70E7516F250
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2020 22:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbgBYV5W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Feb 2020 16:57:22 -0500
Received: from sonic304-23.consmr.mail.ir2.yahoo.com ([77.238.179.148]:38448
        "EHLO sonic304-23.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728146AbgBYV5V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Feb 2020 16:57:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1582667839; bh=8VycBpGz8hZ3tPndsLKcBHgqcsZFnwSsKOwwgzXhjZ8=; h=Date:From:Reply-To:Subject:References:From:Subject; b=hqcUg/HlwsUEaAVtTc4Q0auclH5AKuXrqU2U7dgwfXldATEB/ADoR6U7Urq4Wf6hElkp8Bj7sxohdrYjaG355crXsCL5LQzb6TPdypp1dlE73v2bYPGjNSIilZluIe44kh1tshGlJrp99OU+rLF/nb4SEcZ35t6cK6CgWz688U7XJ1qdKV+s11tm1O2oHpEt5xuWL75Zi3Z+bIpKTGXn+uyp7QOZ4fl9620aqitbDuAE9mGQCxhiPwRGrihE4bRfdrN8IlGHe+jNRqYh8onZ7MWLHR3RIyPeYgYBFG7U2qSaRi5PxMaDYjDqN9UpPDd2Wx+QEKk9xaHN/Bqlfh9L1A==
X-YMail-OSG: MpEKOCoVM1mPRwGGr_2b.37vDGivkdiadN8Agzhko7FNVtKhaiV5Esj6EIGHhh9
 gPFIy7df_UeVwFmu2FO2xu7RtJ1551K4n0KpFvWwFUC87ap5Slf29HcjFDqE76L3ehu7F.Sx8VU5
 _Xh9qbRMYQSD6uP4cKTZzfI0jWlHe7pwwBN3Rph57Y5L2tbvNzWf2QC_Jdm3A9JnisBliHjD7rDh
 E1qyhv4OYW_p5ev7R70bx8NJlHqCdXifOoKpqYkqx3_N6T4OWX27c0H_Pm8nxbjG64m.OCpPzBHw
 qkIDsqRadM7Ji5zjZkoTYQ3vzwFcBA9jpvI1qGPkZ9U3Et3d_RxAcAbuS1Rxacjy2yoF2MdG.03O
 VOB98R.Tou.WspDdH_TcYaIWicXNdSyatrU63gCh2GJUMTTNCQMJaddhYPYpfWvPqpN_n96DNG0R
 ucFuAiXErOft_i5cdVR4dh.qAjMzLBn5EOH0tP_gQP0eFTddPcL5HbS_OMfFJ3CXbILUrpZfGCoO
 4DalX06meji6DTx.quq3xhb7u5i2P8Nsw8KV1u1xvlK.y.DuM_jO7.XL.TRVm88fZNjtUSpPkfbf
 cragvbc5XcdCkJhBxM6z8f4POoaMEu1Gbu4qzIFxbrWeqj.fwAUMBWR474PPYL6ejbIjvoHCp64s
 xYm2VWAKVZ3h1siX53faJWBt8qlWNkdprckcxtMtuhCiEqaWUADWiUXb33NPSRXDvOweh9fbOpKg
 MUehuluHgUjp4z2AEGZBHIeYY7tbTTaN145ztdV.MfSYAM3RgG8Wy0TRCrDPBTd3rLjQGBJt8H9b
 PwFM9a8tLVzAELcs2PFDyDt2XXu_e3jxioB3CBPDh6jhS0LQCe70zfzyBtLJ6xaA0fuN26hJZIhJ
 PjUjWwuGoV1aO.BWaMfB6ZH4xTBKfNoyRKpmBCH2.N33aUPSr_WZUzKphtxUeznh8xmbQ2QW116J
 TT8z9RSOu1vE0e.cHgiTPawtdIqcYtwWh0oz9uNZy8v.XoTy5Nb.od_2HmMTLP04NgYJA7Kd4Zml
 dFoxPWrf8nr2Lxrj40meCpbkZlacztt7_ulrKcH5LI8Ozl4dgzAzTbhd4I8StxAfAJEAwEoUUfaI
 gPpUSbo2yTbS19CE_fqz0ulqW0_MacIl0KOMQY6RJWHVU.KF7f0s0yPM8VgIog4uRGiw9N92ky1n
 c9tNQi5QdXuXoK1xa_EDT1Mzar5VGcrumsrH8EBQUzoxG80LpBAmTAg5o4uwjP1nYEuwHxLXDhZ9
 vGP5s1N_ddcjwo8EYQLqAkt_g8zCBvmK3cHKLFZW8sI2wPuH0SM4fvIKLrCgg0Zeu3DN0ew--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ir2.yahoo.com with HTTP; Tue, 25 Feb 2020 21:57:19 +0000
Date:   Tue, 25 Feb 2020 21:57:14 +0000 (UTC)
From:   NOORA ABDUL <noora.abdul24@aol.com>
Reply-To: noora34abdul@gmail.com
Message-ID: <1484127010.875744.1582667834291@mail.yahoo.com>
Subject: Hello Dear.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1484127010.875744.1582667834291.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15302 YMailNodin Mozilla/5.0 (Windows NT 6.2; Win64; x64; rv:73.0) Gecko/20100101 Firefox/73.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Dear,

How are you today, I hope you are doing great. It is my great pleasure
to contact you and i hope you don't mind, I was just surfing through
the Internet search when I found your email address, I want to make a
new and special friend, I hope you don't mind.

My name is Noora.Abdul, I am from the South Sudan but presently
I live in a mission house in Burkina Faso and I will give you pictures
and details of me as soon as I hear from you.

Bye

Noora.Abdul
