Return-Path: <linux-wireless+bounces-7785-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 972C38C87FD
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 16:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B985C1C24512
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 14:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7465D8EE;
	Fri, 17 May 2024 14:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.it header.i=@yahoo.it header.b="SjZcvxuE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sonic314-19.consmr.mail.ir2.yahoo.com (sonic314-19.consmr.mail.ir2.yahoo.com [77.238.177.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C99E5DF0D
	for <linux-wireless@vger.kernel.org>; Fri, 17 May 2024 14:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.177.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715955642; cv=none; b=dLZpx55EUbN3v1ERgHapFOud5hUt1KO3S+84qw81NKZt/vR+U4raAz6XCvMdotdhTY8bT1HdpjqqSqmljnmfn8kUwEbwH880kf0/OL7OTaPuzFGXP8wKtqFSJajagmJ3kS2L8ivDgJivdRuk+9gsUoqTYkt9pWog7rx/C0abkRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715955642; c=relaxed/simple;
	bh=+T5sPB7ZnC5apBtxhv6VuGvNxi3CPaY1djAF7pHYFag=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Qw4Rj3KSZSeFCYdiGRZXn6Djc0rZnma+oX/OjLyYH0DH1W2WMixHfJWk0o7SeMqlrOXEThBQwQreiXIPvfiJDEnfTh8Sv3ujQZak3NyxR1JOH5HKtv50ZlCDphBYO1l0Lgb6sfy2QXyWm/m2L/v5gKQ9L3UzrOXzypDiDxYP2Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.it; spf=pass smtp.mailfrom=yahoo.it; dkim=pass (2048-bit key) header.d=yahoo.it header.i=@yahoo.it header.b=SjZcvxuE; arc=none smtp.client-ip=77.238.177.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.it
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.it; s=s2048; t=1715955633; bh=/2PEe8Al0xzt/CDS1+tm36v5KGuzLBfgpgs6Zq5Q694=; h=Date:To:Cc:References:Subject:From:In-Reply-To:From:Subject:Reply-To; b=SjZcvxuEcPcG/DbciUzldbY+SBFqlqgFsUBVoJIwEpDGKJa/Ff2AnV2qUnJhuMxtXcLm7mAeDKUbaFWVL1tWzwA7yV0h0glNpNHA/V5+T1ZWLqsrq1Fy4u1z4BA5BwJbZwRYLSu0/x/wlt0ljQJOVY5nw0nFvS25NbP9E3fVX9CWyDmohfuIf8iF/3fu4CnbjZs6DFAr+YpL4E2r9nZjIOkXTVEvLpE0eyjo6VcvNIu0C3PfqIQNzf1kgi7k7upU/aF+lpCXNI93f3eHmZugjVOznNbYLgvjliRGp8t4gbc9hLNPqAmdrRF9NXJ1IJd3moTbu3ibbHDTWCT+DJ7ZqQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1715955633; bh=tQdryNa/eGsFfFhS/zpsi1DiiBvqk0h5sf8x5EsMc9B=; h=X-Sonic-MF:Date:To:Subject:From:From:Subject; b=ja6DNUThTW053jpMM+LJ5rHvBVfv5JKsFz+VLPwvRf0615Oc+hxCtNgS00Ww+mGPHltv5Z7vb8j/tMKOxOBY6+6A6far4Ma7ZxKcI5BkjqeshVi6oMNjv8ffK+UqRQWxGTeKNiRQQhD8MrWPPFf1wiRvHR3s/09OZqRPYlYLawkRbvrghS9zSXma9EmhmNyN7fBpVlulKOEDGqFnDpNLvSoZQDdh0LFCGwvkZazqJbekeh/zVeyrQviprm/Pi8dNuVdknW9o4hdLhbGt5DS+7grSGYYUEjW91TVywy1jBhnU976tWF4LoGN1P7T9UIAQatmdQDHrS2DNLuWUWWSLew==
X-YMail-OSG: D6jCdJYVM1mvxd_GpMRO4R030DhG_VwB7J.ercOEMH_O__ovovE7.kQxcJCznou
 0bz5hcPNZ0OxCD3P0PML9zZbCoiKnwX0r0Vik8P80NDExqxHA4M3aODH3_UG1PrMefpjdd0kb26B
 dWgFe_1RoWxcyIjhVnT1FIHtTZOd18lIFtj23nTqiy4F3NTln1U7EZRatX1sjTxO407vyefM3E.2
 mElBrDHY8HhD6SwZn0MCsbyEjL4RqvnbVjMC2ZbOWZvCPAEzHwKI0dZ1HEczZ3878AonMERsU66F
 4YCtWT7wK7WDAzq5LeW_3M9l_qa6_bT7ltnEQjTewPMMqRT3NeZ_P4WogS.QLJ8KYGPY1evcKjX3
 KMq_CpSYtup2Q_MHx7sVO0u6mzwYna1YnQmR9aiqSNUzkW_XF8HlYVY0HeooQ454XC.OklVyTSix
 L_HzaUXuuz4PPKyoQGMXz_H_HREsyi8vYrqufyfD1i3U4jxdfRo8ZUHmjrjAxn9Lbwz8Q83tv5Oz
 MPQs47xz3Diq2rCJyEz_flg.SEOn7u1DO.y2tDLkprBlHEHrXQ1EISretOdWdJuQnYX3RBAOLUfS
 phC49pbeunh9uLJGFSI8ac0tdXdol1_VpVGXx.TZkgI2KfUf0Huc8uSgTohB1oEKwBJSB85Vxmtw
 6A.hmIOe8p_ZO5zzOipg83KXPyZx1ukhTu4zrOahuaSC6Iel51ybBdQf3KwYj94eIJZWq.Qg5Eav
 FxNJ5kqbQQ13lnnk57XQF2AV6DFpQC5NZQPzB0AMK0ddrqf9yTigVWi06vEXAumtWsevNyTCsOau
 EAMzLFwR8VzDOG48OnfaZadGZcr2tSA4tvqAGAvIRwNsWen3pOphYii3oYn8.EbUlqQxrTOCDhtz
 tGBC8ZnmAmGE3ZN.VUJ4.b4.kzNDg1devlpfUk5NpfAWv57cRj0XNinF9nSsDAWtxUhNayayiruk
 a2uptz2XSvnwiKrWIw1YFNdVs1OgiRrnlWEWN_HuftMP9TaTv0OT6Llnx_sxgs9j0xduB5SrThMw
 e5cBFLYEAKJ_xno.FhX2mMQqB6f.IK19dYp7.2K0jh6pEB3sX_f1akuyt1QElj_LV2cmwYqUQjsX
 n5EPzW3.XXUPZ7VHzQBiXrFQbP1A6g9L7ItLG0.kM_0zDUzCFzZqi_Emj_vsHLcvd8S6s1nBPhG_
 SVZtV8RmZAgxFLPaY4OkB1rUuxRRWE.Vl2M8KdkYW9xQZVVUAcEo7jgPz6dBeasiCYlMKMSInpg6
 yvTEullVNXwplioSODtNjjkfOHpf_fNM3cAEPEcFYWhLu1wgYj.j7t6QYFXoyxyNuB5BKD77kK..
 63VmSxpBOoO4NVxXLuOI4.8vfy0H0EJa5jA6UEWSkMQ2RNhukzvtqC8_9I.qL5aW7Mbgo9HGyxW6
 5Sb.qXnAhtL4QPS2NaNGOaLj9Q4zzb_E7TKScqX8HWZQb8SCTk4722kE2sX0q_SNvfwEWhz4OQq7
 r7H7.WmDat6BBzlfEPz33Yr9dRh1rafv6ZXF9SV1Xx.LtH8bsn7fcf1oufdaxRyP92mwTc1zjchi
 wCgo5sNW4HKv2dCVfJfkvMyMMb3sEtH1GMpHh4SsP0WLtjQDHe90JnJ_u78_7ThdfiaC2C0H8B.0
 eUTJeczSJdv_VCeqvr2QOYHPjcVmUhHQgxdTm8Mu0ywhih7RHPbn2vRrZBnWT54Cmyre1wmewc8L
 GaAdICnRUdOYFbAI9rswfTJztI4xnBQM75XOnwQ7r9rOb5z8jhlO0nYQFrpO1cDDFi.VioA28ajm
 RPA21yZInOxWF_6j9xI.3WQ2eeIyq..4vBrbMFiHU2PULneKkUD0T2iVD5IliS.3WR51C3OqYICy
 .nR0s3TWDfTM5GBu.M5aRO9ORaSyfFOvyZse4M9QSJ8Z6s3jGr_a6jU_rAkfEKUcp6RdADnsn7JD
 ABp5CpOHs8n7OI1rWrchDm1kKxQSerJKA3xxdo.WNAUBQtMBK0co66SlreJp.yckNzIAzFczx1Pu
 P4LIBK6vFkHkpvyrjrK6OgU32qENT7GaZAVdaZrWYII.dAeuISYrSOKrOLwAY1.zS7_CTw.dom_.
 gQhT_8UxAIOkXi0tvpAnHiNFYN.PYOvzqPFFt.Hwo_a21nuCysI4NLjPA.RSSxH3jStKfQes0g00
 iEB1h15fCTStzOtjMoJz.dd.Y1A1.i__wcCwzD3B6o0o3cjvaOL6CteNuZPcc2JyW7MfrNcsFaGH
 QxybUVG2orEnUX.18W2Wy7topMBiSqSVWS8bcJTHF4EIvNJSEjwvW.w--
X-Sonic-MF: <giovannisantini93@yahoo.it>
X-Sonic-ID: f48b7942-3c59-438b-85b6-cc8a78e0a765
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ir2.yahoo.com with HTTP; Fri, 17 May 2024 14:20:33 +0000
Received: by hermes--production-ir2-7b99fc9bb6-4j82p (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a8a5eaed641cc8cebbc6dab33a44e65b;
          Fri, 17 May 2024 14:20:32 +0000 (UTC)
Message-ID: <bbd0d830-5c1b-4ecf-9cc0-194b00475fad@yahoo.it>
Date: Fri, 17 May 2024 16:20:28 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: pkshih@realtek.com
Cc: jjsweat@outlook.com, linux-wireless@vger.kernel.org
References: <1f6b255e8c8a4d9c9d2af80c93b7acf0@realtek.com>
Subject: RE: Realtek 8822ce p2p support
Content-Language: en-US
From: Giovanni Santini <giovannisantini93@yahoo.it>
Autocrypt: addr=giovannisantini93@yahoo.it; keydata=
 xsBNBFWGlaoBCACcYYy4p5OpFH/zYyJ+DYGfr8m712ai0GpJ3hrY4ncmt+cHVYw0pHeR01j9
 t+dtJTwP3Br84E5z/0/mpg5J+LLEHDbAa5Gtal+ykIwtmfZ9N/GEEQvYAU691sCkk+hLSbDw
 vIKOZSMMCV2Ee5R1gY/cM+UBJVFy/DJi75crugb/Fs9OL19YPBR9YqOb1eoE99/5WTbJ8EFm
 Nq+oqSnp3O/7Uln96be3A3ri0a+njr6j1OXneE9NBLQbQx0VJnrTK0pv1oHJFT6fqs3Ar8BT
 tgvaTQ50Q7rBYeZE6o2m+A6tBeC2JGZYCIXXQBirHVktrsmIqy9pnfHxN7hyPuRM6qy7ABEB
 AAHNLUdpb3Zhbm5pIFNhbnRpbmkgPGdpb3Zhbm5pc2FudGluaTkzQHlhaG9vLml0PsLAfAQT
 AQgAJgIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheABQJYLYzQAhkBAAoJEE20cJYvrev1
 D2sH/R4girMykZt+hh6TdYl2RQCZnGd3+aFiL5bKWQH61uMPp2J/DU5ZarxVPBQVGW7vTRZB
 cgceYoC8lnzkWUzlLG9I0pU8VaY87CvwSauRg98L+6eiX42Hz+3xLKbzVT6azewmR47d4WcH
 CF59lin52O3MhMBSY7VoBEPI7w5tJAF80hzXACqi8cnt/yPI/jRE+NFiD+dUiDj0rRecKr5Q
 9z9+aEjfNiFNI8gkrjGwGerlDso7iOjmGlENY3hv0sP+9/Rq58J1Y+Wg4ACTj6s/vjpgcTQ1
 oJxkyoJbEtUVa+B6R6yc2BHECl+JdkDNohxfRMIN3IzJpIQzGaKNATVbaDLOwE0EWDdW/QEI
 AMvkCk1fA/6fXBRuNscDnDYRLSPoMx7tnjOv1Uub9iyFxr2v8B7DKrQq4R0WS4b2vITnsPZA
 WTWJQ4SE0Sx54QGPVjdMzJTMN2cw7y35lS5anYJlY31O89eMpCPDwp88jtq7LKE0Knq5pu/+
 pWFvfysSJkjrFOAKEGn2GEuT8G9BOplafmjyLXv6bwFViUGmNpaTrztlhBaunMDsluoVGg2F
 LPdCdBJpE/vzAOzxg8WkyV+LzPMrz178WTlM0YSCJ/9Ad7QlX0r0rpG3n+HGlhB2Y2hFQM2C
 SlyEstTvMuHQ0Oe5rjnSHxo3FjESknl0csmQmGkPed/DsKigVTeWiC0AEQEAAcLAXwQYAQgA
 CQUCWDdW/QIbDAAKCRBNtHCWL63r9aSjB/wNUBdHtV2j9UQgCpXVcHHA0VSVYSRfvDs0rVOk
 1whAHlg62TKQv2uTFlvn8/lml/Wp7gyW2RKTC9ZIpn3vbgjbW7DuwvjSqCvEt83czRime2jM
 h8URlFRrSFwfNifGxSXsERaH0b7/ae2zfIKRLGhep+/wikTYrItwmW+xXumBVRpkoaKDPy4d
 lhdUxx3EulaWJJgfywYWoieN1jMRcvBWsuexdMFODMPt872NDZhkqrOo+A3fneaELitZdjKq
 NpmY6C9etaRkDnjm70l2cP+RjWY1ahxFuwaOB3ZmNRe3VGyvPTUvdkwZdxaycLgVjEWUJEyq
 H3BYrE7EWk47q50Q
In-Reply-To: <1f6b255e8c8a4d9c9d2af80c93b7acf0@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22356 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Hi everyone,

I would love to get P2P working on my laptop WiFi card.

How can I help this to progress?
I suppose the steps would be:

1. Make the mentioned diff as a patch file

2. Perform tests (need some inputs on them)

3. ??? Profit?

Let me know :)

Bests,

-- 
Giovanni Santini


