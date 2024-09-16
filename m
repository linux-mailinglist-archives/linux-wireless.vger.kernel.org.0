Return-Path: <linux-wireless+bounces-12887-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5526979D10
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 10:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C646B1C21E8E
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 08:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBC413DDDF;
	Mon, 16 Sep 2024 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="mGQkGZMC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="qekINIcQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fallback13.i.mail.ru (fallback13.i.mail.ru [79.137.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046B15647F
	for <linux-wireless@vger.kernel.org>; Mon, 16 Sep 2024 08:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726476122; cv=none; b=DFgVBfh0pcyx6I2myr6tXM1kwQrBJKb63n8xGFM8IquLPpxNMwU3VUqFbZ9/cmiJR1fYJvdIdFuT9QCgwtOkyucfmdwcC5Bs7daaJU/+70B7N+8C0G5Wp8S1zzPJi49CO2QoM8X+iVkkdzVHB5BpCiZSae6L/XLC450DX5xjvLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726476122; c=relaxed/simple;
	bh=R4Gm1kZxkR9A08jzrqM1p0/9FUBEmLQ3Nw5FijD9nSc=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=RXouYNb+G3zmTiDZvSUs1AnjzxaxY8oyehPuG0ryHZiZvMx40s2+0b2SUyeMRZwvuYW65SzG/rvPPvYNXze611dsnoTs0lVQ3laVZRwuqLCrCxTkllORSLag6NfAae8bRTGUhnrvEUpy8trH5KdTJUTvY9s7fwGyNoMcHKghU8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=MAIL.RU; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=mGQkGZMC; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=qekINIcQ; arc=none smtp.client-ip=79.137.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=MAIL.RU
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail4;
	h=To:Date:Message-Id:Subject:Mime-Version:Content-Transfer-Encoding:Content-Type:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=R4Gm1kZxkR9A08jzrqM1p0/9FUBEmLQ3Nw5FijD9nSc=;
	t=1726476119;x=1726566119; 
	b=mGQkGZMCl3v8Ho30riQIzfACFSDGNE+/GDd+kMHSFw53jlxWnlOnffB2jQ3a/jAgksnd9KkyAjmrkB4kj+FBEZwukxbd4b979VIMWlyUv+HcTVTg6/8xS5ilEypnokU0snbMZ/uc9Zc+uY7HOU8tDd+MG0Sf7q5r41y0EYrqDxLdh91pxWZIpTNi3CYFniRk0K0vFePp+E0PljdznauO2jaxvpACA6M45mbYBMbub6JzSVEabQK81CJN/B7wwa0PwOgV5IJFHFOMkeMPSDyczMkc21AzQuNO2YFm5EJUcBcvso7jYW7ip99hHoi/SNWWqYyws4j5ywuHdOse4u4OhA==;
Received: from [10.12.4.23] (port=59894 helo=smtp49.i.mail.ru)
	by fallback13.i.mail.ru with esmtp (envelope-from <gibsn@mail.ru>)
	id 1sq7Ir-00DzKu-Ml
	for linux-wireless@vger.kernel.org; Mon, 16 Sep 2024 11:41:50 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=To:Date:Message-Id:Subject:Mime-Version:Content-Transfer-Encoding:
	Content-Type:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=R4Gm1kZxkR9A08jzrqM1p0/9FUBEmLQ3Nw5FijD9nSc=; t=1726476109; x=1726566109; 
	b=qekINIcQKt6h0EqLPd/ijibasOx0M9KSnxhR4X5BzABlBvteX2yk6PGT4I/7+f0oPxXRyAem8vE
	9VWUqEWpwZ4iIefPwvgqvx+MyjZ3dXJQv1K8ITUFURv3B9UpvJuDs2nj5HeJMnb8FtKgS7TePrbbD
	G2hlXw3xJM+oUgBFGFiui8jX1HMF3ABLt0XXIa0RO4JtZG5Ln7+UmImmJC7o6t2alEtP/YI04N+66
	Wb732tXO68TnwDHqiMeCyRYOfLxqUu/oaZ5h5xl/emTkIyUEw05/dXdUBpIKjZKb2DhVu0qgwAvU5
	Fx0Chegrl6bJc9/jxr+9P8OgRnrtpPDOuVJA==;
Received: by smtp49.i.mail.ru with esmtpa (envelope-from <gibsn@mail.ru>)
	id 1sq7Ij-00000007leW-0umj
	for linux-wireless@vger.kernel.org; Mon, 16 Sep 2024 11:41:41 +0300
From: Alekseev Kirill <GIBSN@MAIL.RU>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: rtw_8821cu: read register 0xf04 failed with -110 on kernel 6.9.7
Message-Id: <50FCFA28-0EBF-4525-A3A1-66987E9D83B7@MAIL.RU>
Date: Mon, 16 Sep 2024 11:41:30 +0300
To: linux-wireless@vger.kernel.org
X-Mailer: Apple Mail (2.3776.700.51)
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD90521F83352E4771DC39C749D00CEEF229660C0B4B1ED76AB182A05F5380850400C42DB4FF00FFF7191417EB218679B829B5F7C0BAB063FAB681E73FDDFB71B645C562C83BEF8E994
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE79145AB6E9E75F07EEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006374D0D183F14C070BA8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D847177CAB8C1AB2914BFF6CBE2FB8FDE94B94CEE19749B12020879F7C8C5043D14489FFFB0AA5F4BFA417C69337E82CC2CC7F00164DA146DAFE8445B8C89999728AA50765F7900637028599BB38096F4F389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8241FAFF9BB01F7E7F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947CE3786DD2C77EBDAA6136E347CC761E074AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C32DD6F6D23C0CE254BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF3D321E7403792E342EB15956EA79C166A417C69337E82CC275ECD9A6C639B01B78DA827A17800CE7F45C1E71A9DFFA2A731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A50246252EF5AB91F25002B1117B3ED69638E01874F3FB1851108A05421C070DB8277AA237ED671D4372AF3B35EA4094CC744B801E316CB65F9C5DF10A05D560A9D2B5782620B851B7C8C84E951CD0BE2F58C12E6D310A6D536FC43C45D3E35E8FA71A35648BE338CEED902CAAD3CD6B00BA7CCD254A1CF5E8D65ECF394A061F45638A446BE3E5C627BF0CFE790FC11A72BA7CCD254A1CF5E8CE878137A7614741
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB774242A1950755802D361004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D34753B45383CEFF204060AFC42DC2169A18F64A575F4F5ED60E7C79DFF49033FC4192305C0E1A03C101D7E09C32AA3244C1E6716893C9EB8260091A80DA37A96F3391B22F01D0C9E0DEA455F16B58544A2C99F59F2F009F096195DA46F52C91AB6D0A763FB597667D12D91A05FF0B355AA
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojnH7hiPSwZxBmNtqJlIESiw==
X-Mailru-Sender: 11C2EC085EDE56FACDC9ADABA4387503D4451A8104AE8BC9B951B70A5BD4BD8EB6E38ED26D4828407AD558DE3329E3440A3122A1A745A11649DA2CB244E35F8331ABA76AB88B244AD81C002505BD82E1427D4802A830920B22B820C1B2086D890DA7A0AF5A3A8387
X-Mras: Ok
X-7564579A: 78E4E2B564C1792B
X-77F55803: 6242723A09DB00B4EBFCE21E1429DC4D9342BA332C073518D1924CE71205D7DD049FFFDB7839CE9ED333ABE5342D7AD06A9A44C3EC20175DB47951736D948F56602C7106C1A917B4
X-7FA49CB5: 0D63561A33F958A5173D5D9E64DF4F1B2B0CC80590948676C5CFC07C253C4842CACD7DF95DA8FC8BD5E8D9A59859A8B626B091936CF41E0FCC7F00164DA146DAFE8445B8C89999728AA50765F7900637101E20BD66E287C2389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC85DFC16F0B797518DF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA775ECD9A6C639B01B78DA827A17800CE75EEEA65FB1D00720731C566533BA786AA5CC5B56E945C8DA
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojnH7hiPSwZxD8AJ4mxQmswA==
X-Mailru-MI: 8000000000601000
X-Mras: Ok

Hello

I use a USB device with RTL8821CU chipset and it fails with errors like =
this:
rtw_8821cu: read register 0xf04 failed with -110

Device then becomes unresponsive and requires a system reboot. Usually =
it takes multiple days for the device to fail this way. Full kernel log =
is available here: https://pastebin.com/NnnRrEhF

I tried (with no success):
- setting usbcore.autosuspend to -1
- setting rtw88_core.disable_lps_deep to y
- setting "Power Management: off" with "iwconfig $iface wlx1cbfce468596 =
power off=C2=BB

I use this server to serve media content at home with Plex Media Server. =
My OS is Debian with kernel 6.9.7.

Please tell me if you need any more data to address this issue.

--
Kirill Alekseev=

