Return-Path: <linux-wireless+bounces-26608-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8E8B35561
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 09:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06B6A3AFF87
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 07:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8324A2F83DF;
	Tue, 26 Aug 2025 07:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="zsvZOH/a";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="lMLGOCIM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779C52F60A5;
	Tue, 26 Aug 2025 07:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192835; cv=fail; b=WpPLTItDvyCvvbnFG9xmrP5zOH31/g3mga1TtV8vAm/RAxBGgmuY6CXy54QaTXaocivEDlbF6m/oMZfCueP1hbL5d99Y9eCkPL4Rq9gM449iT08aZ4bqI1QjLLwljAz8Nyh1sqkWjWREdU9XvXRyrPpNaoJkfrGlukeHe+RHDLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192835; c=relaxed/simple;
	bh=oHfCyNUk/uEESQ/Zuc97lsH2OgyTkQH9TEC1SBULyIo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ax5PzGc1uJsPQ+SwVc9sMZxXyYGMMa532qOPGyZNoIWc9xjV2mOAg0mIyUtDfBToWKTYvPWXCwuoHf+UqDyzrfEMESoW8zwrPvBBWeYlkRyjM0ZJovKHYPDQ+ayayGaaUOfMoQIw+ZlI/YS+tUKK3dNO9cL6VI583RKJ0Gcd23k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=zsvZOH/a; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=lMLGOCIM; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57Q5P1Zb3402875;
	Tue, 26 Aug 2025 09:20:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=270620241; bh=dBwwjf2Vg4jYkTiOKJmbtY
	s8o6Sf2Y2KLyMv+unCOKY=; b=zsvZOH/a+ivgm+H4cs6FFNMTZFIDuNDTd7auB8
	HzbrpxPok4zzareKo0JujxlASnIhh5lU8W+TjQA7O1F9fk6OTVKipDsiNMey5H3j
	gK1Yuege7W0aeEkOO8KRS+IvCO41t+SK5a2Wr2YOPwz2W0fdzK/UFruLS5rR+jOg
	LHcT1tmcW467iYgL3GFMPsyX/UUoKiCx37MPXoDsehL006X7BUyvd03bBdyQVo05
	bxqLWBC9asRlQI36YaFoSsDT7iurR0/59GwQAYHlN74QkPCYPo5Skt868XdQaB4u
	FLrFAZmZ9AsKDOtTMaNpxXrFa5SisxVepcjV0Q5elxSU7Kiw==
Received: from eur02-vi1-obe.outbound.protection.outlook.com (mail-vi1eur02on2097.outbound.protection.outlook.com [40.107.241.97])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 48q32earse-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 09:20:11 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omlN8nl617xYtE2+MiDJaMbWElBWOwJtPKxyjEsviaYcvAK+X9BcEd36cayz6DTu4ZyW5a9swmJp4g5B2WMTIkEuVRfq20IVO/FZkmC2SN8H79jHVxy6k6Fu42UAZsAKJHg9k6OWoYjJyT9yi6Kj/7kahWMTmc5jficxU3dtxmj5h2mIfLGthrMhVujiW7bd2spRwnKBDZn1WWsO0r5Uvi6bOOVb2ti4lkaQpEN98JGVOBJh9capP8x8fN3g+L4HF4P8gEeOYIT/krVCfTRS2nwylXB0UH9yeGCjp0U2fGUj6rioLeEOSEutlFGXwO+Fl/I5ST2Ypk6UR6FnUDeDNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBwwjf2Vg4jYkTiOKJmbtYs8o6Sf2Y2KLyMv+unCOKY=;
 b=kCoQX7cV8fUDArarEV3dqTa57wHTvyLCskAynH9sAXjI+hHpH3eyLANl6BRD2hfwNjJTz79gRS4nmFiV6K1NpslfjdA7baM3ChEy68XZbc33Tav0qT8YoZOpeRcfJlKZNp7Jo8x7zLryFxASOR1Q1DVr6pwbAxZOrROHKg3kxTT/GPPHSjt4PLvlMP1bG0jkV/+eCf2iXgueIZ+fJcWZj1E6AcOLpvyCVBVKXoPR7JxAhlIIljqpjEm3Y6Qr8EYmB2DSQBDPOa132c9bZI4TkKPfG6KzzOsmFrso1yqNw2XYXk5a0oLO9h1isxM4FIUWVEJ6g7mJ2A41ZbUK9L5VmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBwwjf2Vg4jYkTiOKJmbtYs8o6Sf2Y2KLyMv+unCOKY=;
 b=lMLGOCIMyVzeSVW7l0AWctjp+J8vtvNFOCUID3cRA6bws8SUoOA7fFJSwlZ1Nwn5JdNKg57OXN3NsDLFSot+TCjkFOCqs9h3WksachP0iOs5WLLtgJXOs9Ak7y/ohbP9Ren02oKcrVJ4/RJA4s6CBLmmd+0MlugZYlTIrGfM2aM=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by DB3P192MB2107.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:438::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 07:20:09 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9073.010; Tue, 26 Aug 2025
 07:20:09 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 0/4] wifi: ath12k: Fix endianness handling in QMI
Date: Tue, 26 Aug 2025 09:20:03 +0200
Message-Id: <20250826072007.1395416-1-alexander.wilhelm@westermo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1P189CA0007.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::20)
 To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|DB3P192MB2107:EE_
X-MS-Office365-Filtering-Correlation-Id: c5b7f874-fd8c-486d-2d19-08dde470fd5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YnoH4XHaKw2lWcwlatRcxdL0Y1VDlMUb1k9uCKR1PtGZG68TrhBUj1b5pfRd?=
 =?us-ascii?Q?7NKYM2sSmknoQuwCz4TkzvBsoZhXD4Y7upVpS71vvQSNUzgBNUhzFL+wwFYG?=
 =?us-ascii?Q?0n4u5G4r3bLcooJc3rX323PwyomAYWe13TfCisHF19lgC9dzJYuFU+3HX2Lj?=
 =?us-ascii?Q?7fsT/Lw5tGWktxc4opS4bBVTlnB+gAVsz/vEFrRoPBPCqj/PAN8uaQNuq6/h?=
 =?us-ascii?Q?ywsL8VJevby+VMfFQ6kbSfXH5tojU2PMuYpU7KNtToO8sBSM+FQtXYcfHeZ2?=
 =?us-ascii?Q?BTmfhSW6DiHQucamtdYJieGItKesqXN9Bs2uAk0i0iCFxI2rNgpCONEXgbN2?=
 =?us-ascii?Q?4H/6ckzEvQyJlcyZqgrXQoGxCsRq2/TXqKbrWCvEMthkl1ZGv8MEgdwMf08t?=
 =?us-ascii?Q?TpvoAu6ePkymVBZEc9bGL8itj1p+Ro27c0J/dUyDT0NlnxZryDTpRIDBK99g?=
 =?us-ascii?Q?u0839ekqVO6a4aBXCXbe1jVQtPMv6vKWhs66lW5aQDnykg5YfBphSYEVI+v1?=
 =?us-ascii?Q?+vjcNlbmGre8JnhKGjQ17e7EoxpzEEkKyYMWbkTtlF6UcWXRHp14Hv+BgQUZ?=
 =?us-ascii?Q?muU6TBDlDgEEhdRs2/YMsp0P1++2ZSlbweCffaPFvLO5BSBhn4yDU3ST59hx?=
 =?us-ascii?Q?n1BT78i7GsuZGsdZ9Bpycv2ZZZHXK8RFF+47EoAqsYZYE7UK9bFyxhP5+J4c?=
 =?us-ascii?Q?UXXnb8Zsj/XskARugTPsmGgbMXDaLA/xhq1j7Hf3bBmnLpUQ0ZesaonHAUQ2?=
 =?us-ascii?Q?fpz2uLcApRGtjmq7FjTdh/i72GCaUecVKNmAoYfONKrggnAEH50LB+kRcT2z?=
 =?us-ascii?Q?XO6L9ecKORpzwpJPSJ3yR/KKFHR1AsdJJAkbZC/Bwvkm+q0zms+GX0TtLkCq?=
 =?us-ascii?Q?3TII9KNay4QVpk5+wp6HBrWihjQslyZEAxLRmwK1CM7ru/G1L4ULYMea0QHw?=
 =?us-ascii?Q?LSDJxNkD8HOULL4EwMFP0pMtJAfjxQKY/kiEVaXMzm7AaD7wWkstGugUSFKX?=
 =?us-ascii?Q?ijoqdyn42d+1X4lz2mpInT7VhRZGmYgPQQmB6Dh96MvmJcHDt9OiGZIJB8i2?=
 =?us-ascii?Q?ZTFav6rngKCUyOhaQJRQ+IbVYLQLYamrdWTSNquTXhBMRDQPIOOPfoM2iyIN?=
 =?us-ascii?Q?SusQzrWzsajpGsAixNuvzAdcjnj9lhBfSF35rwrWwvw350PN1ajQ8CGXyr/w?=
 =?us-ascii?Q?AMs5nazRUA5jqONCMWOp72BAb2wsbNabMOxbVx7MMk/5AXGZwqKDWbzipS9T?=
 =?us-ascii?Q?H67XxKYxe7qoBexa3f7macrK8F8nlEEE3kNqyFQ4qVTnbgImk5BZtT+Cj4Us?=
 =?us-ascii?Q?xHzlsvUxKAMnoEOnDnaiuNxXqPA6KaYCe8N27+jGbiARs52VbxLbHavaHhyK?=
 =?us-ascii?Q?+kl6a03fetlUhaJgrCS9tYsaYWZ5YLf3cboz3hqYpt8gwGfZTgA4qN64HINm?=
 =?us-ascii?Q?MVSH/jV6gpw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fH4KFHjvJu93oL+3AUfdtFg3rvLx8AlNSJe8GXmn/3oEbNFQsPVYu+02Gn9A?=
 =?us-ascii?Q?FnQw5Gfj0NWbEx/neyXFvRD/uSwF1KLEZzGigkUIqC/sxjsbY4/Lre7CdQwa?=
 =?us-ascii?Q?ZI9LQO22KSTUMS1Z/fvMWqOPtAItJUhujm/CF+nDkqFBJSnxFincRKqNhq2G?=
 =?us-ascii?Q?Vj0wUNS/9/ykWKGq1nXa+7Dp/QFHKJJocgSGBNQ7IRePLTHPwhnLmUiRLkb7?=
 =?us-ascii?Q?Gyg5eczwUi/ltJy02GSdCHGdJ38HXSoW4v387yjBCVzP8ou5CZLuJuZKw6FC?=
 =?us-ascii?Q?3hvh4yfyIa7vWFa/wwnCXWeSvBF6X4TQ5zxUVsKxsvnh6vICnYmjfdsJn9Hj?=
 =?us-ascii?Q?q7BPhscG0TinvTjMA9OaUzN3JmEPxdvvZmZvMtSgq7ayzCFQoeik+x9NSSoY?=
 =?us-ascii?Q?Fi96a4jQpUe/aHe8vLTt99cJpOdy9BbCktio+w02GmckExO5DYFY7FCAAn7q?=
 =?us-ascii?Q?YbRVsTMrS4JdW1J/P5lbk1qx583wXQV0cerZdRJ2cC6/BIyIfYhYkiQnj7+Y?=
 =?us-ascii?Q?N5wAzXe/hQIWxLUsm7Oyl5b2hWI6PPRf9QHUCUP7KV7dO7TAnwqoSWKr/nZj?=
 =?us-ascii?Q?Z35pn2/jUyYIA4EyYncFstN0WPB1fBaWvbNUlfChW8RDoZRftvtGmBiwo7Fn?=
 =?us-ascii?Q?sgGMKjtfYEO2DnIaeMD/864KaI8aktjW3SlAf13nRabk2u+DMDTgVqQNcRyv?=
 =?us-ascii?Q?50G/qFvTU+96/lmn1Z8OSD8RUu2KnJlAc5KjWpcmSvf+bPIIsfkZSz2XZc6Y?=
 =?us-ascii?Q?9denqPMdo6m1qlYCfjQZERn8V68oeYaZ/DNBi9fHJ18Q1uK12fZwrH55I4+z?=
 =?us-ascii?Q?mhTnM16brsbWCc5vXROAEckMXWL0+taY6kLZ3dTULkreovMwuDaUF18ZaZfn?=
 =?us-ascii?Q?y47uCl84vxNRMhxE9aVsxWoDmPu1h89BKjNkroGZQSrMGGBrQV5vmb+F/Vhz?=
 =?us-ascii?Q?DbsxbPfxJtyEuOSdWxwulMPX0sANQs5CxWchS8J7zFkwxkinqE3PVVYpcR+9?=
 =?us-ascii?Q?bzzpDrAv+CmrD1C7cN6l6zxtoWhWDLiGysZf0oyk4B4bGaiDf2tjPTsqpaTx?=
 =?us-ascii?Q?JzGc8NaVB/LLMC960/FFrh9D/BeRCfRV9OUeDiCcKdNjYLWyYJ88L9AwEAuQ?=
 =?us-ascii?Q?BtZ9+XRReBkeNOoDyNaFK020P6g2sgDfWxQnVF9Ekqy4fQgW+iscHwTlJtUJ?=
 =?us-ascii?Q?KezVlhexhPKQicc2cz2XK1RZ5k84jqyvznnPErV34JD+3vs5fQEurMJCv/YG?=
 =?us-ascii?Q?arujICraaREaUnU600K0z2lPHqtr6tvPsCHFmwAnnKEpM7LxKVLx7RnO4RUD?=
 =?us-ascii?Q?YxEt7OUZkfQQNNmMkc0bcLfXmSwfAAcF1c5cOMH5fXQAhcuc8GJA1ElDtm4P?=
 =?us-ascii?Q?+0hj3iQ1giLgz7l3jq1N58crjoilQc8ZRTvQlt9RBl1EhU54oBW6F8vDSTsq?=
 =?us-ascii?Q?iyVozPqI4t/5XxrV/DANXspwBxfXd4AnokL5KYk4BZrabVGEMB3Akm64ioDf?=
 =?us-ascii?Q?VJfWo2W4QSdS/96GFuoYiYTYPdIodGXLsG6XjpIKbc9+bunP9b5+vsekFSFN?=
 =?us-ascii?Q?W9Tsv5XWPa9XInalV2khroD34CjhvAe62e9atXJV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7ljqDsuJxlXgBw+XO5htP/rdUqwH5XoeSA+88EwJvKPUSWa5MVsQg0cG+JJfj49zX2Qjfg0T1GoehiQrrWcd5NjUYUkdAoJ40ykHmQtD+aPcNw3QaamzfQI8bVLG3dKpkfPWnx+eg+Tj67a7PB/Ot2sI8QAAPwmLcCYNHh5aBczYYyjKgUSrjwVVAWG2Bp1BI1b1uHLbxRPBKKQog077/6a7khTuuuDrs1+q27nIT1fgGbJVOkh34xdcMH9sDpJlxyviq2iK9sLF9CkaxoIpkiSnHrevxl9u22O0bCkcnPV0+ZvbS/5R+tScsLFeFFkwJAvD1MkM6Uqkf2RbuTRkeCrEVqi2WceQhSCcLXO7BXU2scGEp4/UfylPcw+wjxPk/7JkXmbULpS9/TJj0DZ2e5RkyJDP9v/j9QKOH6DPeMgDxn840a9lUlumX2kc1CBgwzMOJ/Rl9Zwc7BMPRNo7FgCaBMIxJd0Js4zLMXSqTuTcyrwd1RTUae/ztfLs0ltuN32vQukqfx4c52xyS61m/oivNXQDtNyrppep27HCKdAEDzJBjRFxbYyswmOBk0IHy3W9CX6keDZPYlIso621wdcZR4Dcf9H4m17DJVids7RkuDPYMfwojovKWWoIVfSn
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b7f874-fd8c-486d-2d19-08dde470fd5f
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 07:20:09.5374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q1yxTYZvwE4011dJO+apzO7GGEPpG2BTDmLjsMtajBOMw/stjy152k/gMRVvQJNHWA5d+ICZA8X9U0zPvqjkfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3P192MB2107
X-MS-Exchange-CrossPremises-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 14
X-MS-Exchange-CrossPremises-Mapi-Admin-Submission:
X-MS-Exchange-CrossPremises-MessageSource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-OriginalClientIPAddress: 104.151.95.196
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-Antispam-ScanContext:
	DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-Processed-By-Journaling: Journal Agent
X-OrganizationHeadersPreserved: DB3P192MB2107.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-GUID: kJ96VH0B2KqrcaWxFpXDfq3JmKYOaG0K
X-Proofpoint-ORIG-GUID: kJ96VH0B2KqrcaWxFpXDfq3JmKYOaG0K
X-Authority-Analysis: v=2.4 cv=P+U6hjAu c=1 sm=1 tr=0 ts=68ad602b cx=c_pps
 a=pIDtdkxesOjdA2ZcUpuhbQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10 a=8gLI3H-aZtYA:10
 a=fIT4UxgXLIuBAtv1WeEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDA2NCBTYWx0ZWRfX7E1MdGms+n7N
 WdoopJQmpeweLEb2sldmjffkqzyVYSWt3LpaS9t9qLzsQyPy6frVlP6PGZ3S5u6HcdP0FTptZMq
 5lV/mf5JtNbhS4xeU8/N07mBFHA5jKy8JqCSY6R+Ht5s+uOXyKIv9rD1iDFs1EvKZBfTzikD5cT
 ycG56IaojWFs+9eqoXjCQk9oooVx9SLRadb2HdnXhwc1u68GosWlXy5a6CfvPKQKiAvVaAwgZfH
 IqP+91Vws9ZoB4HKD9v6RE8z5VRRrkJleA3aqKymqQw/cCOynYfbrLd8sMU+LibZu/BReqJQ6wG
 SowldqyDS5Zwt8arnSqNLsWVyQD/tdDHS45WhwLW+8QD0LdtNPSNEap6ZQzkhU=

Fix endianness handling in QMI firmware transfer on big-endian
platforms. Without this fix, the firmware download fails due to
misinterpreted data structures exchanged between the host and the
wireless module.

The issue occurs during early bring-up on big endian systems, where QMI
messages are not correctly parsed by the driver, leading to failed
initialization sequences. Ensure all relevant fields are properly
converted between CPU and little-endian format in request and response
messages, as expected by the firmware. Attached logs showing the failure
before the fix:

    ath12k_pci 0001:01:00.0: BAR 0: assigned [mem 0xc00000000-0xc001fffff 64bit]
    ath12k_pci 0001:01:00.0: boot pci_mem 0xcd4148e9
    ath12k_pci 0001:01:00.0: pci probe 17cb:1109 17cb:1109
    ath12k_pci 0001:01:00.0: pci tcsr_soc_hw_version major 2 minor 0
    ath12k_pci 0001:01:00.0: request MSI one vector
    ath12k_pci 0001:01:00.0: MSI vectors: 1
    ath12k_pci 0001:01:00.0: msi base data is 0
    ath12k_pci 0001:01:00.0: Hardware name: qcn9274 hw2.0
    ath12k_pci 0001:01:00.0: boot firmware request ath12k/QCN9274/hw2.0/firmware-2.bin size 15134776
    ath12k_pci 0001:01:00.0: found fw timestamp 1722934582
    ath12k_pci 0001:01:00.0: found m3 image ie (421880 B)
    ath12k_pci 0001:01:00.0: found fw image ie (7229440 B)
    ath12k_pci 0001:01:00.0: found dualmac fw image ie (7483392 B)
    ath12k_pci 0001:01:00.0: found firmware features ie (1 B)
    ath12k_pci 0001:01:00.0: features
    ath12k_pci 0001:01:00.0: using fw api 2
    ath12k_pci 0001:01:00.0: dualmac fw selected for board id: 1005
    ath12k_pci 0001:01:00.0: Assign MSI to user: MHI, num_vectors: 3, user_base_data: 0, base_vector: 0
    ath12k_pci 0001:01:00.0: Number of assigned MSI for MHI is 3, base vector is 0
    ath12k_pci 0001:01:00.0: Assign MSI to user: CE, num_vectors: 1, user_base_data: 0, base_vector: 0
    ath12k_pci 0001:01:00.0: Assign MSI to user: DP, num_vectors: 1, user_base_data: 0, base_vector: 0
    ath12k_pci 0001:01:00.0: irq:18 group:0
    ath12k_pci 0001:01:00.0: irq:18 group:1
    ath12k_pci 0001:01:00.0: irq:18 group:2
    ath12k_pci 0001:01:00.0: irq:18 group:3
    ath12k_pci 0001:01:00.0: irq:18 group:4
    ath12k_pci 0001:01:00.0: irq:18 group:5
    ath12k_pci 0001:01:00.0: irq:18 group:6
    ath12k_pci 0001:01:00.0: irq:18 group:7
    ath12k_pci 0001:01:00.0: pci after request_irq msi_ep_base_data 0
    ath12k_pci 0001:01:00.0: cookie:0x0
    ath12k_pci 0001:01:00.0: WLAON_WARM_SW_ENTRY 0x2
    ath12k_pci 0001:01:00.0: WLAON_WARM_SW_ENTRY 0x2
    ath12k_pci 0001:01:00.0: soc reset cause:0
    ath12k_pci 0001:01:00.0: MHISTATUS 0xff04
    ath12k_pci 0001:01:00.0: pci link_ctl 0x0000 L0s 0 L1 0
    ath12k_pci 0001:01:00.0: pci reg 0x3164 instance 0x11 read val 0x11
    ath12k_pci 0001:01:00.0: setting mhi state: INIT(0)
    ath12k_pci 0001:01:00.0: setting mhi state: POWER_ON(2)
    ath12k_pci 0001:01:00.0: mhi notify status reason UNKNOWN
    ath12k_pci 0001:01:00.0: mhi notify status reason MHI_CB_EE_MISSION_MODE
    ath12k_pci 0001:01:00.0: qmi wifi fw qmi service connected
    ath12k_pci 0001:01:00.0: phy capability resp valid 1 num_phy 2 valid 1 board_id 84934656 valid 1 single_chip_mlo_support 0
    ath12k_pci 0001:01:00.0: intra device MLO is disabled hence skip QMI MLO cap
---
Changes in v2:
- Handle QMI conversion within the QMI subsystem instead of the driver.

Alexander Wilhelm (4):
  soc: qcom: introduce generic QMI encoding/decoding macros
  soc: qcom: fix QMI encoding/decoding for basic elements
  soc: qcom: preserve CPU endianness for QMI_DATA_LEN
  wifi: ath12k: enforce CPU-endian format for all QMI messages

 drivers/net/wireless/ath/ath12k/qmi.c | 24 ++++++---
 drivers/net/wireless/ath/ath12k/qmi.h | 16 +++---
 drivers/soc/qcom/qmi_encdec.c         | 74 ++++++++++++++++++++-------
 3 files changed, 79 insertions(+), 35 deletions(-)

-- 
2.34.1


