Return-Path: <linux-wireless+bounces-21820-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 475C3A95C30
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 04:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0471617814D
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 02:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BE6221FA3;
	Tue, 22 Apr 2025 02:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="q2zYTawP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011027.outbound.protection.outlook.com [52.103.66.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7461E213230
	for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 02:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745289393; cv=fail; b=nCPs5rLRRQs659j9atseRwSVrpN650nPuKdXCKmLvhXKxZ9WVr1HrmVbvuXgdftVSgoH0Ks4BMw68jFD4ACo3oVV5EJb+Y50TRpVgY95D6HAMQWYad0nrD4MkKqT8KK4IfQ4XO3k8p0PwK/yezanmomhvpS/8+YbMSbEuH/FFms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745289393; c=relaxed/simple;
	bh=xSFjRs1+vHKJRLPfgTczqPrl9DEa7oe30LD3IAlYTa4=;
	h=Message-ID:Date:Cc:From:To:Subject:Content-Type:MIME-Version; b=mTAZzH2lzJRcbHM/rjr3C17GyghNPYZJmHruX+7IeNnlyuCgiwBKqC+4zdizN3zw9LUa5eT8Lm0k5ZsZETwCZkMxhS57Hxp5/5rhgaBFgo2aK43PrP3fJmt0242q2ICngUeSrA018TOLkhdHlhNofjkeAhA1KhHz/WkZYrqeTIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=q2zYTawP; arc=fail smtp.client-ip=52.103.66.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1KLgtlKscYKUeAm/Br1AsoVbJO0Hk8y82p+V3yJk9KCoSo8KUesTGF4o+jvU4ggk09Q439vy5UkzZ9BK7EHdbQjuNvaHrYc9+DICkuyl/zzA15C1yB9kBi1piOQYmM/1PQe1pD4lqac4hMH3DalSJPZic4lX9ociF/dugfLqWJMuDoPEjzQp37oulxmEtSXRtw38JFR7YaBIXt5RH52feCPnerBe64OxcgRKg3TFDiaBQZAMoFA55jVFjUM+0M0Y1Wd2cGUfYu50pvalGvqR0mugDtNTXyetUcK5CPOeWCcvrRhJ9fbzyDGSpdb7tUmODytxdxXtRmgn8irJIFpqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSFjRs1+vHKJRLPfgTczqPrl9DEa7oe30LD3IAlYTa4=;
 b=Zif7ETlGGTb3z/mQzqObIaFDAyqlIrbC/CMX1G5J+WpCcdkcZl7DFFZEd9oFPii7AWw7e6l/EGpJKIVkmDLz7odgKvo0MzrbmWAcnPruMaBxuYbWNRup14Ps9BhBm+7VHlxIIllWiHRz+PuaXlADGdX9mJJJCy+4rcQTPJqyLols0DtlZu3uCyBGS20lT3vSVPdDAt+QxMDh7YSJdq+Wh4VPhr9wSQBasUjHqWq5a/T1Tm8sO9yfJM9rE0unnnIY/mw1z1Xn018FErA6Rfo0r+X1KPR4wNHDAq2SP+8g8PxGs/m1q3HVcgEzChH+UVWoXDA6ayAFo/ziD/Siw8UEiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSFjRs1+vHKJRLPfgTczqPrl9DEa7oe30LD3IAlYTa4=;
 b=q2zYTawPjYP3/OdO5+uk8RGqz3j/s5wuQKM/9T4X0KKcsL7DE4trrfRwkwUGm30Y62Q3+VAX7wny0/mjqMlrhkY4udrKygcodlOB72HS800mlAF9EDCZ3D+5B1iJk+WzDQ2qoQEbJZWov3hlSG9QhKcEfhu6h8fSEnR96Iao66DBrK3jsDHEtr8x8dGX1WIu60b+d3RgoY887uXFLZYtpUrGMamw0LPZNfIhoYKh5wGpb41pSwco/4YQVJQ2NTnMZD9/BY89sUiVii4cp+5Q4S+IcVkWK+E3FgJRVbeoa/xuGHV5qKHwFs9FBbTtxUFLvbnE9WpqAN4m7WI3y0zMEg==
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com (2603:1096:400:156::5)
 by TYYPR01MB6682.jpnprd01.prod.outlook.com (2603:1096:400:e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Tue, 22 Apr
 2025 02:36:23 +0000
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f]) by TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f%6]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 02:36:22 +0000
Message-ID:
 <TYCPR01MB8437584CFB57F0290F816DBA98BB2@TYCPR01MB8437.jpnprd01.prod.outlook.com>
Date: Tue, 22 Apr 2025 10:36:16 +0800
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com, linux-wireless@vger.kernel.org
From: Shengyu Qu <wiagn233@outlook.com>
Content-Language: en-US
To: pkshih@realtek.com
Autocrypt: addr=wiagn233@outlook.com; keydata=
 xsFNBGK0ObIBEADaNUAWkFrOUODvbPHJ1LsLhn/7yDzaCNWwniDqa4ip1dpBFFazLV3FGBjT
 +9pz25rHIFfsQcNOwJdJqREk9g4LgVfiy0H5hLMg9weF4EwtcbgHbv/q4Ww/W87mQ12nMCvY
 LKOVd/NsMQ3Z7QTO0mhG8VQ1Ntqn6jKQA4o9ERu3F+PFVDJx0HJ92zTBMzMtYsL7k+8ENOF3
 Iq1kmkRqf8FOvMObwwXLrEA/vsQ4bwojSKQIud6/SJv0w2YmqZDIAvDXxK2v22hzJqXaljmO
 BF5fz070O6eoTMhIAJy9ByBipiu3tWLXVtoj6QmFIoblnv0Ou6fJY2YN8Kr21vT1MXxdma1e
 l5WW/qxqrKCSrFzVdtAc7y6QtykC6MwC/P36O876vXfWUxrhHHRlnOxnuM6hz87g1kxu9qdr
 omSrsD0gEmGcUjV7xsNxut1iV+pZDIpveJdd5KJX5QMk3YzQ7ZTyiFD61byJcCZWtpN8pqwB
 +X85sxcr4V76EX85lmuQiwrIcwbvw5YRX1mRj3YZ4tVYCEaT5x+go6+06Zon3PoAjMfS1uo/
 2MxDuvVmdUkTzPvRWERKRATxay28efrE5uNQSaSNBfLKGvvPTlIoeYpRxLk7BN0xi/KZIRpS
 lIf0REc1eg+leq2Hxv7Xk/xGwSi5gGxLa6SzwXV8RRqKnw2u6QARAQABzSFTaGVuZ3l1IFF1
 IDx3aWFnbjIzM0BvdXRsb29rLmNvbT7CwY4EEwEKADgWIQSX5PUVXUNSaGVT2H/jUgzJGSnI
 5wUCYrQ5sgIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRDjUgzJGSnI57GwD/9O6kei
 9M3nbb1PsFlDE1J9H27mlnRWzVJ2S3yJ8G1oJo8NSaRO7vcTsYPBYpEL1poDQC5MEGh6FXSi
 OnyyHrg8StmGLksQE9awuTnlnQgvXDQMVtm87r1abBAavP5ru2R9x/Tk63+W/VT2hPekMfHa
 JwFi1KATSI1AhsF3CVoj0yDulz1u0uZlircKdbeEDj+raMO0LA12YxWaWtL/b9XaoAqV9vor
 aKhx+0DsZS5bWoUvs+715BArPBr4hPqKavsBwOWfzWDTKln2qv8d+glWkmk6dgvZFcV/9JEJ
 Q8B7rOUMX614dqgwi1t71TI0Fbaou3nhAnES1i1it/aomDUCLvRwjGU2oarmUISFgvZoGYdB
 9DfVfY3FWKtfDJ9KLUk9k3BFfBZgeAYoLnFZwa3rMyruCojAGTApZtaaLZH/jzQf7FpIGGhD
 YnvGKXS01nLCHuZSOEvURLnWdgYeOtwKW1IIcnWJtB12Ajz2yVu3w4tIchRT3wekMh2c3A3Z
 DeEjszezhFyXgoRpNYDBzNl6vbqhnopixq5Wh/yAj6Ey0YrIUbW9NOhIVCGkP4GyJg756SGz
 yPny0U4lA+EP7PS3O7tE0I3Q5qzDH1AEH2proNlsvjZeG4OZ9XWerI5EoIxrwZcOP9GgprB4
 TrXUR0ScTy1wTKV1Hn+w3VAv6QKtFM7BTQRitDmyARAA0QGaP4NYsHikM9yct02Z/LTMS23F
 j4LK2mKTBoEwtC2qH3HywXpZ8Ii2RG2tIApKrQFs8yGI4pKqXYq+bE1Kf1+U8IxnG8mqUgI8
 aiQQUKyZdG0wQqT1w14aawu7Wr4ZlLsudNRcMnUlmf0r5DucIvVi7z9sC2izaf/aLJrMotIp
 Hz9zu+UJa8Gi3FbFewnpfrnlqF9KRGoQjq6FKcryGb1DbbC6K8OJyMBNMyhFp6qM/pM4L0tP
 VCa2KnLQf5Q19eZ3JLMprIbqKLpkh2z0VhDU/jNheC5CbOQuOuwAlYwhagPSYDV3cVAa4Ltw
 1MkTxVtyyanAxi+za6yKSKTSGGzdCCxiPsvR9if8a7tKhVykk4q2DDi0dSC6luYDXD2+hIof
 YGk6jvTLqVDd6ioFGBE0CgrAZEoT0mK6JXF3lHjnzuyWyCfuu7fzg6oDTgx3jhMQJ2P45zwJ
 7WyIjw1vZ3JeAb+5+D+N+vPblNrF4zRQzRoxpXRdbGbzsBd5BDJ+wyUVG+K5JNJ34AZIfFoD
 IbtRm3xt2tFrl1TxsqkDbACEWeI9H36VhkI3Cm/hbfp2w2zMK3vQGrhNuHybIS/8tJzdP3Ci
 zcOmgc61pDi/B6O2IXpkQpgz+Cv/ZiecDm1terRLkAeX84u8VcI4wdCkN/Od8ZMJOZ2Ff+DB
 bUslCmkAEQEAAcLBdgQYAQoAIBYhBJfk9RVdQ1JoZVPYf+NSDMkZKcjnBQJitDmyAhsMAAoJ
 EONSDMkZKcjnnIcP/1Px3fsgNqOEwVNH7hm0S2+x/N/t3kz50zpKhczHZ8GWbN3PPt4wkQkd
 bF+c7V4uXToN4a17bxGdUnA9qljxt8l3aEqd4jBqLn2OJriu21FSnrZOpxb1EwWwvnVUwrLx
 CuV0CFQJdBlYp2ds64aV8PcBOhQ62y1OAvYpAX1cx5UMcHsNVeqrWU0mDAOgvqB86JFduq+G
 mvbJwmh3dA8GnI2xquWaHIdkk06T55xjfFdabwEyuRmtKtqxTP/u6BzowkV2A/GLxWf1inH5
 M81QgGRI2sao6To7sUt45FS+y2zhwh62excOcSxcYqKzs/OiYEJjWMv9vYRwaqJGEVhbfGFO
 jeBOYr+ZCCeARh+z4ilo1C2wupQT8VPsFiY9DRYgkAPKlbn9OqJvoD7VhvyelJagSNuRayrr
 mnEaZMsoRdS22fneCVWM0xlGSgPCVD0n9+6unTnVbmF/BZsEg5QufQKqlFSomu1i23lRDPK/
 1aPc2IoxcQPh2fomy8spA5ROzOjLpgqL8ksEtQ75cBoF1K5mcC2Xo1GyDmdQvbIZe+8qwvQ3
 z9EDivvFtEByuZEeC5ixn4n/c9UKwlk+lQeQeN+Bk7l8G9phd4dWxnmWXQ/ONR/aLzG+Fguu
 GNZCPpu5dVQH44AXoFjoi9YVscUnWnv8sErY943hM8MUsMQ5D0P2
Subject: RTL8852BS support?
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0sTmQ22vSK4xA8RBQ8JBaekb"
X-ClientProxiedBy: SI2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:4:186::8) To TYCPR01MB8437.jpnprd01.prod.outlook.com
 (2603:1096:400:156::5)
X-Microsoft-Original-Message-ID:
 <e1b6505b-d25c-4331-a016-af4b7e20197b@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB8437:EE_|TYYPR01MB6682:EE_
X-MS-Office365-Filtering-Correlation-Id: 990719cf-0b21-45f5-7a9c-08dd81467862
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|12121999004|5062599005|5072599009|19110799003|7092599003|6092099012|15080799006|8060799006|440099028|3412199025|13095399003|26104999006|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FqUld7DikM/mH25L+T/m74p69eI3N8gCUVM82i1kOYurVNdS0jN0fj/gp133?=
 =?us-ascii?Q?nLUQzsPxDIaVhWgqeS9D0y9JYrYClHsUWTg62LzoWLLuizqrgjxMDEhzsfXO?=
 =?us-ascii?Q?orpFPge3AqX2xINwHxg8nVUGxqio7UruM236u0QL5RtTYBQiXWdw/yIZ6pYD?=
 =?us-ascii?Q?L4LaAEgUJkUts+xH82vicNujgJMX8R8YruDadniozUcVacoB81ozn6t85mnc?=
 =?us-ascii?Q?Jf5jQo5ehuaY05UKByre8ct2WfEPMXULBP28ZXeEqFhKRPyXXt7lsQs/f4pO?=
 =?us-ascii?Q?DXJTz//dSNqyJjrwurHJyhNBbQ4ZHBKgaBoE+KI07ect6qbY/OF2fuc3WuN+?=
 =?us-ascii?Q?pVHOsBBDsP9XF8I8PbAIh6wVPADAGN740kOoedIqcl4ZcRapNfR4GtIUn4z7?=
 =?us-ascii?Q?mbu/mIuYv4vpJoP7J+Mu3dqtwS/pMDhBIHU4pZv7eopngiRhgpYdgMqhcUd+?=
 =?us-ascii?Q?jmDBQ+Y5lCBvr3oJH6p3+Q8QnPe2y8+oEklB/NsnLHY1Q9SFy9YmRTcCnIA0?=
 =?us-ascii?Q?SXrqr5r4I4caB0HLTeErIbTFKf7Gw/T3eHONNfuY9LZJXTdLLmOJ3AGQD7Sn?=
 =?us-ascii?Q?BD6x49A4IiAGp5eR1OZV6m8wF3lRkJmLY8CFOziVuoIKVnoX7oWjlwnzMQNd?=
 =?us-ascii?Q?MI5Jr4ISZ4JzDUBrjRgsdCEI+qD+z8UF4Y413tKJJaQIhb+zUz7HkbJW42+7?=
 =?us-ascii?Q?OFl8iYhEhGH4aA9V/c3y5s0b+QkbVNo94na/wSPH2wF1RG3kJh6q/GQC3IFn?=
 =?us-ascii?Q?udFZLrZxGRWnEDiklN0VhCiee8GL/x2qN1UlmXRN3mrvDE9xDC5BrzKzaCDa?=
 =?us-ascii?Q?kgfAmDG3nk+R346d+UmZ05krmBAEq3X0oRjmz7h2VpF5vPSABaNnCdNQwFRZ?=
 =?us-ascii?Q?cHSNlyaym7PKLYNnLDpZiOUas29kwhwdStFAjtPq8XHUi6TQWBNma870Kred?=
 =?us-ascii?Q?t5KK7MIKo//Orybf8R1IdsnmvEoti/+dUzQ6tLXSNRJ4VVe8cl14m5vCH2Mt?=
 =?us-ascii?Q?gYvizCH2oiNZO5CCcG4yNfbiMf79GKs+URc350UIXlUdHGXzvilA/ivJJkoH?=
 =?us-ascii?Q?cOU+H4+Ku0eHkOKEdaAR1QE+NDgy7AVlrgL68bNTfNJZsqQddtf8JmtX0s0q?=
 =?us-ascii?Q?wwzxwigffWXWORC+/z6Q0/7unoI9+QA9uqyvu6NmUr3eUwzkC0W1NLZHkfQg?=
 =?us-ascii?Q?o5njSkkyym9ogTMJf25KL9bQumLV2ZKUuKB57L5eDCzu06aoIEBOiZjEWzPV?=
 =?us-ascii?Q?9t5VQ7T1o9uOsY/UwC0dnlhp0iE0+G2Le73j4H48madxflv800YH1c67q9IE?=
 =?us-ascii?Q?sck=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4LGqFAclaV5M7ShzLVJSUZcKhsWcX7tIcw6MlrlXMv3ZDwYYrx342eQr8S/y?=
 =?us-ascii?Q?+V00+jMjX01WpfF9et4Jwob7BoT0X+TAAF2BqiYj+8HSvZUeqsDwqch4Dq3i?=
 =?us-ascii?Q?+spDiNW7yvqTrKgOYk9quHWk0Ra+6mSOBNA+65bmu67m92bRD3XrwIP7WaWV?=
 =?us-ascii?Q?OhubFzFfFWLwSXMuNazsdCiZW25t8w52HBDCPmdnFdfibXqEvV2bhiYPTZef?=
 =?us-ascii?Q?v6+KS7lr53of08cGocbFMl1BrFsA5SKmfzzBdDDzo/yyWD4Yy5N/UnIRDIOT?=
 =?us-ascii?Q?7Pnpd730TB7TGia8Lvzw89B7sVNXqTFWjDfrAoa1EnYmz4Q6FsicyNywhMbL?=
 =?us-ascii?Q?H4QMNYlqzIObd/IEFIOzG7vHmcyyX0DD0r1jSXh1y3UpK73qRedlSdPD0XbT?=
 =?us-ascii?Q?MqaqjMUdUCZgORL4WTeIp2ZnODrrZnSCAzXGApDX6K//XSp2SyoRpfSbnsUe?=
 =?us-ascii?Q?B3Umep9eWO87jFrpraKTpc4fpRz70pXGHF25MItwJSIKa8xv/IgTDsGuwCCH?=
 =?us-ascii?Q?PTBKsJYLOHGYauYBF4+yq9koYK4uXAzWRQmHoklfEw/5vIZlGncPn+D0RkU3?=
 =?us-ascii?Q?9J4v8cReWJXeYmIvglUSZVA9rW4au4PsWCh9xT/53wWYYfV8ECc4iCRmfeTi?=
 =?us-ascii?Q?EufLmz8EO438PRF/82H4dbE+r5q34bVxi2ro0FNln8a/fEqPPnNpxUBGB3Oa?=
 =?us-ascii?Q?Bs+yyLNAdHt1PzKzgbxAJYZBgmAlDeTe+3J+/BJGooOvPiotTZftVlEzqTZd?=
 =?us-ascii?Q?uqAGmPEabRtglg2g9IgQ4cttOPKg7o+aXvZy+glUM4cqtV5TdyaXzaQqkH0t?=
 =?us-ascii?Q?5Qj0OKl+H/XklNzRNZlq4w2x20tLauKUBCR+AWRNME8bsKKyrknqSUh2obQ2?=
 =?us-ascii?Q?qI/jxyA2r3wziYsVbUXzrQfEkWYLOW8PacBOVw8i1tm4FLOSyOo9lvptYBEQ?=
 =?us-ascii?Q?ya0WfGXPCkHI9kIXz6/0kKh2jBsX04Fj0VGayvFAnGEzjbrljY1Wiw66IT4W?=
 =?us-ascii?Q?hR6WAQERuK1R0B06pm3ibgX0kdD6kd0Wl1/DDBiwnaDJo+eTzX+0I7eFipym?=
 =?us-ascii?Q?pUYb7tlrVFpjDrIiGB5fojhQadFUqWfvXTXMp0xTC41IO02zbzp36CJIyR/D?=
 =?us-ascii?Q?nwSqz1mU6pksnsvwRqJhtZFDpcBPTAqQG2JRl3P6Y3IkjCEH0o7X9vYUqH3o?=
 =?us-ascii?Q?Vns7u78FCOq2l5pB5G0yhMl76NvwxWMB7HQzN9dOXThvJk9FLXH0GzECaXs?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 990719cf-0b21-45f5-7a9c-08dd81467862
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8437.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 02:36:22.8351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6682

--------------0sTmQ22vSK4xA8RBQ8JBaekb
Content-Type: multipart/mixed; boundary="------------VlA9Jq0SfSvtbfT9irCxtS7U";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: pkshih@realtek.com
Cc: wiagn233@outlook.com, linux-wireless@vger.kernel.org
Message-ID: <e1b6505b-d25c-4331-a016-af4b7e20197b@outlook.com>
Subject: RTL8852BS support?

--------------VlA9Jq0SfSvtbfT9irCxtS7U
Content-Type: multipart/mixed; boundary="------------K7zSw7tt2tQV99IoLauvF0Ca"

--------------K7zSw7tt2tQV99IoLauvF0Ca
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNCkknbSBnb2luZyB0byBidXkgYSBCUEktRjMgYm9hcmQgd2hpY2ggdXNlcyBhIFJU
TDg4NTJCUyBjaGlwIGFzIFdJRkkgDQpjYXJkLiBCdXQgaXQgc2VlbXMgbm90IHN1cHBvcnRl
ZCBieSBjdXJyZW50IG1haW5saW5lIHJ0dzg4Lzg5IGRyaXZlci4gDQpXaWxsIGl0IGdldCBz
dXBwb3J0ZWQgaW4gdGhlIGZ1dHVyZT8NCg0KQmVzdCByZWdhcmRzLA0KU2hlbmd5dQ0K
--------------K7zSw7tt2tQV99IoLauvF0Ca
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
scUnWnv8sErY943hM8MUsMQ5D0P2
=3DUrys
-----END PGP PUBLIC KEY BLOCK-----

--------------K7zSw7tt2tQV99IoLauvF0Ca--

--------------VlA9Jq0SfSvtbfT9irCxtS7U--

--------------0sTmQ22vSK4xA8RBQ8JBaekb
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmgHAKEFAwAAAAAACgkQX75KBAfJsRnS
sw/9EqKWE3gpfk+4GgjI9JdhFb4+ucJp4s10Qbysaty0LrgviXUhHx96EQwZSRxfJCOmAVXs3oDA
haWbaPOKjj7PCS26zdvDdIFepntVXtm54R19zw9rC80/RiX45RcQQB80RkyKBgkTAvxVUJVeG1Mn
FHPrD/uthvxgP/7lVPu7bHWVJK0m/g2jrbW2l3w588gynx6c2u+wAEABYga3f9Be+hzPUWBQJfUE
/r19GXbZORm8g9CAXQAXPUALczmNZ9ZufckvHWTymRAd0nEov6pausTm1AYP1AtJoCRNdTYGDPRk
HJq0rQ5E8NWtVEBBBT4zCPcIbMM+boYt4FoywAfyuLYJrsdBgscPLk6p1+ilI6GwidgurvcGj5pk
RgeGhFzCNIFz35z9tzlybVVKdhxN/inMak3KTlf59Y5gVmsc65SdJZswND0GkVIPTpBqbf5Fa0WF
ej88fkxfcM+XQg46E+M4Vpp88u/cYMYW8HVtJ2enc3xSIZhc+8xKJM5HIu+3chskw8l7EnLIMIvh
sdZ5EE2h6SHjAk8NiEgWnCS0tTpqCoB1gwbH2IB4U0fd/D47GPhzkN8khkAgI6Vq2KoSsAb3YEhB
AkVBGoLYGRQTJwNZtryVpn6PbH/66kZU9TkNrT/spnaYE2rQ9lzaO+5WHygP7kl/yGr4cf0f3+Lg
GRs=
=NhX7
-----END PGP SIGNATURE-----

--------------0sTmQ22vSK4xA8RBQ8JBaekb--

