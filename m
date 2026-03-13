Return-Path: <linux-wireless+bounces-33184-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGNIAIyys2lYZwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33184-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 07:45:32 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 514D027E4AE
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 07:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0704301B910
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 06:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B29D315D5D;
	Fri, 13 Mar 2026 06:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="N6wS2Qx2";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="Txl7bFRd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587B53537E0;
	Fri, 13 Mar 2026 06:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773384326; cv=fail; b=Sh11Q2It4P/2tAXCR63XReGVAgf9xxAH4VDMK1R7WdfUhlUq2pBGVIZun5Pi/8KiEdMONs8Bhc5ZOmYqg9pDISw/fgYxk73YfEm6jZP83J1TXKly4xK1O1ya3sNwbslZNsAAqf4DaCXG7Ph7d346qzwaIE9wKExDMf1e3JzQTGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773384326; c=relaxed/simple;
	bh=p+wnqi90Kd5g8vNJmxcnuxKVdP3hsoG+ziG7ILAyZTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cHGPktTxYGNIRNvg1LlbtKmnnHHig1g94i3bXgtlDY0X/GvVJCB47FF0kEYieOaD6vMxmBLhAT2NaMITnvMNaqaZXiU96VKE6ZVgRj4m6fGXSali0DM5eNb9V0yys9gzyUIbXljk+/yPxGYSg4pX+VzY2yVTUdmZRpIi5BqZ7/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=N6wS2Qx2; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=Txl7bFRd; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D5T05x2028945;
	Fri, 13 Mar 2026 07:45:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=270620241; bh=ab0Z0AmR7YCVjQkAlxB1Iiz0
	F3e3eLrMmuH+E6ovwy0=; b=N6wS2Qx2ihqrSKDtWgJwODsLIxkE+tKFaMzyDNqd
	2GuddivDaBW5gIovUzQTOZOTwnw5RVLwYToOqE5c5/EU0ec32i1uVO4fINnrrr9F
	cg5MjCxeEGEbvHIIXaiaHt77bmPf0Zti3fqFWiW3+Cy9+PTz0TM8PJcyIYi/oyPL
	YzGLU59f4KVRIrBL212f/tLknxP1lzXJJ4BfM4PAvrL+gr6T4jP4otjHXLGvJ1FF
	4t9IpPTENVQ9uFxtMYQdhy6TBWkobUlU7BzjUEFysQFdz9vibwUrLAMgHqXf2xle
	XxnrVt5p+9MPYgx22l8y8aDbWNcuMsYboJQbJ/N6rVD5lQ==
Received: from pa4pr04cu001.outbound.protection.outlook.com (mail-francecentralazon11023088.outbound.protection.outlook.com [40.107.162.88])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4ctxy4jc8s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 07:45:08 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wVMQzgMvoFH/vkQyNzwdw/av5fiZWRssDT2zNiQnOqqbbGsYoMK3Fee/dAaA0KqKYVt0L7Ccj/kLtZ2H4PCmOCdBt4dQ4LhPjrDbJzHs1ozwJqCGzMwvU/2o552kh9cQrxZBI77vUKyW42VqDGBHMAE93mroCaFRYeMQcwgLyRow17qBCuuij1j3s4L6NfrE7HkvCSLcu6qTYwd1nmAudgUbnnCB8/j5AZ4Suxl7bZLiZmGG3jcxuR4eB6EGmdwhQuRJg4gbq0EQ1YhKmcrtkIi0X8LdPY173wdtZrGMmphJEdtmD3EYbBvcXiCPeMXB6lPlZYwxO7OLuGQAuoitIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ab0Z0AmR7YCVjQkAlxB1Iiz0F3e3eLrMmuH+E6ovwy0=;
 b=ueJyHT4LZC9iXXEx/9GmmUb7HBHxpuVacNUd4WLHeNJkGP4x7gJdoMfTd1WMtew+urzFcguE8/yhbct0Uv4VVbg8Mr1jH70IqKeXpAUljdlJMG7l5625u7qN0LiZEp3cEfWpVoVmdlXeYyZOhikwkfYGr8EgsGmHJrTXlB61LP8xLQY8fVvzSrxhVrE3zlzYtM3SkDMFRDB445gLqb27ygINyEz6SwW4+LB/cn64Fiaizg4NE6vywIxxip7fZPqzY6evfliFOGQVfBr6SAxMO9Aqp9cpjDcBZbr4irDG/Kp7IBKUFIA/k3B5u2aopdE1fN55ZN3WQgilVWMJjKpTlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ab0Z0AmR7YCVjQkAlxB1Iiz0F3e3eLrMmuH+E6ovwy0=;
 b=Txl7bFRdVQaPOhbZiJBpISLv5jTBRoMfjvDzxT03el1XPXl7/1glkBkN4+5Ip5U7aYrpSIEvo+Tot+rgDLgdTOvnmcXd1M1dylIqYadjfxXpPwIfbw8hSK40mbBgNYMmSBngX7Bx1MB+EMhs2euxb+CQrB3arWO8Al14zcYnL2c=
Received: from PAXP192MB1168.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:1aa::17)
 by AM9P192MB0949.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Fri, 13 Mar
 2026 06:45:06 +0000
Received: from PAXP192MB1168.EURP192.PROD.OUTLOOK.COM
 ([fe80::2346:6c82:47c:cee7]) by PAXP192MB1168.EURP192.PROD.OUTLOOK.COM
 ([fe80::2346:6c82:47c:cee7%4]) with mapi id 15.20.9700.010; Fri, 13 Mar 2026
 06:45:06 +0000
Date: Fri, 13 Mar 2026 07:45:02 +0100
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] wifi: ath12k: fix endianness handling for SRNG ring
 pointer accesses
Message-ID: <abOybumhX0YBf2qS@FUE-ALEWI-WINX>
References: <20260311102416.224621-1-alexander.wilhelm@westermo.com>
 <6948d3fb-d3aa-47c8-9a40-4ad8e3b72ce7@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6948d3fb-d3aa-47c8-9a40-4ad8e3b72ce7@oss.qualcomm.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: GV3PEPF0001DC06.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::268) To PAXP192MB1168.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:1aa::17)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXP192MB1168:EE_|AM9P192MB0949:EE_
X-MS-Office365-Filtering-Correlation-Id: 0be75fea-aefe-4433-2f65-08de80cc0f7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	sx0UrLVf1xcePAm91lFNicRSKtN/BY0dyNCuwGximmJ425GBflxFui1FUOqPYd+qyU6gJ/qU7uLo8y3RAfxOwNx6tGcsvY4QVNw5fgH6IDrTVGKnXjt48uf8Wwa6J6/5T51vt4voKnWi3ryA7N4eZgVU0Ku3S3p8DKsBTQQai10wmry/gna1ta+LfGm3A23IOPrdNWff533S6UkRWjPlaLnwEMdhnIFK0QDBYoc1PH4D2gW38SWgZrbLwJKEZ+NQRxyFtpsbpJt6d4uu92v/SDIPKI5licR58zwrWX5/+aCWaSH+K7NSQDdI4vBoxaJUzUUxw9FTYE/jBHZgFx7Puc6nzM8yDZVAiSu0a2W1q4xrsabGG/LO/SDSSwNycLDwK1dRk+23J9QeTxXVbrZE6c30992cQMfnlu7HKfqv7HmevGX1DnqiEQYzzOPMqhGw7d9sihEbVsu02L4xxYf56djNJdPXQBEZkVgT/3FXIrpEXFtn1LaKllyv8b/fhx822HN9FVxgofCB//nhDzbkC3TVkKHAIl1MnIkT8j/sZzzDTLgSFg3Kanot+LxuEG5yKZSI4QdaeAtFzILM/JSCfdvZMPSSaiRYU9ciBJRLkv2ymThPVc0tI0/1dP5inRTJ43aovpzJMiW8Laik9VCwfInZNRMtNgDRKb9gkaLA5MQ2rNzxaK9eMtdk5wHOQMZC5TFgr3ytqOL93v0ED5YISLFfKidgLBmqJuQhVJmFDsc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXP192MB1168.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?58WNw0dJ+BqhC6FzZVKbwp6i4IprNX+RtyU3Agmf3xVZnbg5AxeA9TFLfAxb?=
 =?us-ascii?Q?mH5IusNK7BegP17pnDBRNaXMFFOgguzw5Ed2bntTuX6dTwK35Tel9i/a/qvZ?=
 =?us-ascii?Q?URz2IF0WYpSRowu5pVN+X7lyx+WiIe1gIuAvDTO7hMqiyQLZ+EFRGkiHor3w?=
 =?us-ascii?Q?gLVb1n5rHDwnDwLS5Shek0UfuoeNWiI+78MD2UdGOiqYZtoYTaCgD4HbG1mS?=
 =?us-ascii?Q?/8VBaFFG6gmIhJSgTontoZh60IurTdw6eBDLwZM0OfPJsE9X4XeNj+DiRa4B?=
 =?us-ascii?Q?vqeKtn42a/IpGZhq8ie5GWYI4bZrhYF8mUV9jBLcBqiXLzdwgR3P92LCAbP+?=
 =?us-ascii?Q?cjhWl6P4RxUl66SoEOVglux67I4Qptsz25+OC3s6McFGpiBVnDLB+uy8FKdR?=
 =?us-ascii?Q?TE3ySlJZ9+pu6eISkP+Hb922zls8iUR1P/P73SPv9NqEB2aux9l+aODDzfyz?=
 =?us-ascii?Q?XdQqlyha4A7DvCU0qJnKYm68ChHLPuok8ZDgaBb7Jz9WF030hyYXEfipCeJC?=
 =?us-ascii?Q?s9nGWw7OQ4Kz80Zbn9UQOv64Sp9rwUHCwnsojlGkR6NifntksonutzsT68qp?=
 =?us-ascii?Q?eYQk10t0dCo7G4HzuPv4vcR9B0XkJENuXRN0GS68y9ZPC7YFKYiU7gnu+r7a?=
 =?us-ascii?Q?J+m49zPISp8w8RUJyMvMfpEt6c95VswHb/KX3G//ztf6p2BT+vratSgUHdq1?=
 =?us-ascii?Q?Dgm73o4thXkx6nEl1U6F6T80/wERtVrcqv6hvoe/cfXVOHMz/0NYxwkqFacv?=
 =?us-ascii?Q?dgm4/jGCmzJxM1SjEzyrBH8qsSoNY5vIelSUzENCzuvL5iDzV+DC3EaWSOz1?=
 =?us-ascii?Q?f/ORX9GT0r94fhEN4Eid76+ZWZMkS/uYmFDStaHvJYg1JcQXymqBb6XIhI8P?=
 =?us-ascii?Q?kSWfZvgJgz5pgEfOAmNMeWMiY6ZnkCAwtgIr6fXDol1yV/Q+/NzITNt8WdeF?=
 =?us-ascii?Q?QUz96jHg7qTJHtuPVBzSS3lQ6bgh/2iFczV0ihSZCYXuPqcldlHGuJsBIQRH?=
 =?us-ascii?Q?U5YFNveU0uClKQBSKP5/r9ch3Rwu1nZp0y3Ofr8yd5wT8zsd/14UXNk6n6hF?=
 =?us-ascii?Q?spLM1xTT27r19swt3zpcv8s3THIorgh0YhfPU0g91sOhDcf+6+nNzP/SKGM0?=
 =?us-ascii?Q?HiMbK1ftGOOQBU7lUSPX4qzmiI+vYb2ryHWt9k17Xa90vGm3EGw6Aed0E+HV?=
 =?us-ascii?Q?1RV/Cikc9qKx+RJImnVek/XB1ga/Plf9I4I2VWlFED0R1OoCKE8S/+u2yCf5?=
 =?us-ascii?Q?8PJO8QiYS5YGfvH804MJuGno5q2yDNKHtSoXzwnMzIoJj2T44cwbOpym0d8B?=
 =?us-ascii?Q?Qv3i9JT88Uf+pxEZf1J7cP0WHGo0qZ3kMwV556AEwhHgMz2ZWSUgqjeSMT3Y?=
 =?us-ascii?Q?GtBlTfjqW8DsyfwGUe/35Oml5mPG1GmeM1ApEgDB4PPKPYNdhDZ6EStRpHFK?=
 =?us-ascii?Q?57K88SmGUgRbtpBFPf6j6AVm9eLRXXFZfqBGyl7ZHiR/CleO7DEcb5K3xRsd?=
 =?us-ascii?Q?qIN0Pv/2bZ46bo7hW6hk557oGw0LFj34EBHFRr26csPH/CgQz3Uzfmfuf5/e?=
 =?us-ascii?Q?1BKWvniyns2/yQ2DjPzThyLG64urly+3NgaT+XCTFm4FEuBFtj7E+GqEzCYt?=
 =?us-ascii?Q?R9GtXdWu7+h9pYL2onmLjL//tEZtoMoc/pLp6ygVA0ev1QVvZXy0Oxkd8/YS?=
 =?us-ascii?Q?hF7yvLfGvjmR4Kg3Qs/cqg03MWebg4SkzADqiZk5z3Oe5QhoGRyWtQyUDUqs?=
 =?us-ascii?Q?KvWJjhGNpQ=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	AxTQHnHl0Os4q3ete3y9jKvVgvm5WJiqNMwnZ8UelP288Nf3uo0C85c9FziZ7JG0aSFLBEesmi94jnWPvMceQRdxUVLdsXuG3TdETgqWGvQdWPqoJ/eJm5J/a7rTu4oP9UdET5Bf0OvZdHHapWpWUKQQCW6vEvOgk5rsd72TwghmdWHzrWWWvfED4sY0PJRc6Z0ConVPwfZEyYw3veH4rAdkYAtJWvYpDKeIyijy4ivsHxbBDAqktFzn8W24PcUhOLKOdmnDA8QtA9WvJNCc13Zx5KlQAfR5kOAPG51pJJDG46iBwPqCW8mvXjnXaodipX4DvvPcPS55e0ppCBJyQw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	z0Or8Dib572e2Kmjk3Z/UJ4HI9KGyaoF6s3Ae2CDnlJMaHKHurhw3l3BOrE066VjPr3njWhU/fS6LlcNrkkptlRXa4xmKrn908NsAi/lJpfEhnstE0DB0pYb9HY/MzRcdmt+OWwJhErXUrxt7x8UEK1tyLGw0cNHKFpe5nFeAMG48L9DneEvyMpHMETkxGA+cFlgVr0HipZ2Nnm57QPpzbKUxLfb0EmZFvZ9J7gqbE0G8caO1pjLtTHgpKx8PImHpAOa/+stv4d9Qb5aJyeVr89W4yhQKfcIG5C22UAwrTVHSjLyDssp2H4NZJAsMvw3BO2/7JPQphJj29ttQxi/8VUuctpupYOPK4vm8/qPpOHSccIKrZjXa7dDdgIfJ46Llk18nS/gfKts1XUfugMmCnz7kJg19Q37rueAPlxAhcvPn74Tl0IIhozir3GRbvKaE7s65swQJzmPiR32Bl1ZMifJ+C2DQvoJALEx6jLQZQPI4W/AlgVII/708IwHcTxeSIMYzZNcwgsBBNPOhLtH4u3w3nUww5R6YgpLA1SoPM+FXA7yt5IFD22y52N+rhDpcqSkkLQG+k96UphKh4AA00E0O5lPFjvz2lTfBXm4wIYYz6JBw2wIDf43RUvhfkFf
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be75fea-aefe-4433-2f65-08de80cc0f7f
X-MS-Exchange-CrossTenant-AuthSource: PAXP192MB1168.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 06:45:05.9444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tO0qCIsy7R2NArrgwr2fh5Gk8fmZAMlfviItPU4xY3iuynnCwbOpmABqRnqxhkOSbR54Xp5/2kQHIYeA6lYfSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0949
X-MS-Exchange-CrossPremises-AuthSource: PAXP192MB1168.EURP192.PROD.OUTLOOK.COM
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
X-OrganizationHeadersPreserved: AM9P192MB0949.EURP192.PROD.OUTLOOK.COM
X-Authority-Analysis: v=2.4 cv=deaNHHXe c=1 sm=1 tr=0 ts=69b3b274 cx=c_pps
 a=TaqVD0UdxF8uqnHHxsVPFg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tr3XZvuDWTETL0Uaxejn:22 a=8ys4xmT3Mru1TjC2zVq1:22
 a=N9GNhs4bAAAA:8 a=EUspDBNiAAAA:8 a=jyBwj0xElQ-m7anZU94A:9 a=CjuIK1q_8ugA:10
 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA1MiBTYWx0ZWRfX09SIlBGDBMZS
 tNIPV87QqGZj7Q9mXytN8XzXFH3rx19y2BGcfSNN5z4/+FWEiTw/pi1q2vMSzQSFX2Yv3KqMC0J
 HHCIOvnezCnExOguBEygPcWEc5kGi2SKURNrB4zQriuWBLupjV0Kd+0astl1mGaGsQKwKHEMwnp
 NLZsF4GbW2zfyxIRt9oIyU+QKLTggtXzyL3Ku8TKJEJocg4bXEVLDAH7Uo43kWYm4r//EauC7Uw
 9nzPEDHRfzAHAEUck+N2ooo8HRFO59ZtWrlliPBf/wZBaOJjxGVX1EtTExOUG0ysIhE4lYAGR/F
 42cHfX+tAAQ0U+SvMhsv2HmyG/ojTfeQ2EYTKrYirZutKtoK7bVLD5/90cltDSE+iS/lJMKMt0P
 WKvtUEp0gUQwXLXzEI9qsto3MIp8TMQ02e8PA4Q4VaWdts4RYtvRyzap8DlWbHMKj2ZP/MrqYer
 0kBwHtxvp31nyUw/Ycw==
X-Proofpoint-ORIG-GUID: tKX02aFRmN_rhF3hhUJwQD9d2GsXknPV
X-Proofpoint-GUID: tKX02aFRmN_rhF3hhUJwQD9d2GsXknPV
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[westermo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[westermo.com:s=270620241,beijerelectronicsab.onmicrosoft.com:s=selector1-beijerelectronicsab-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33184-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,beijerelectronicsab.onmicrosoft.com:dkim,qualcomm.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[westermo.com:+,beijerelectronicsab.onmicrosoft.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 514D027E4AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 10:44:52AM +0800, Baochen Qiang wrote:
> 
> 
> On 3/11/2026 6:24 PM, Alexander Wilhelm wrote:
> > The SRNG head and tail ring pointers are stored in device memory as
> > little-endian values. On big-endian systems, direct dereferencing of these
> > pointers leads to incorrect values being read or written, causing ring
> > management issues and potentially breaking data flow.
> > 
> > This patch ensures all accesses to SRNG ring pointers use the appropriate
> > endianness conversions. This affects both read and write paths for source
> > and destination rings, as well as debug output. The changes guarantee
> > correct operation on both little- and big-endian architectures.
> > 
> > Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
> > Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> > ---
> > Changes in v4:
> > - Rebase on latest 'ath' master
> > - Remove volatile from `hp_addr` due to the `checkpatch.pl` warning
> 
> by 'cgeckpatch.pl wanring' did you mean below ?
> 
> "
> WARNING: Use of volatile is usually wrong: see
> Documentation/process/volatile-considered-harmful.rst
> #64: FILE: drivers/net/wireless/ath/ath12k/hal.c:504:
> +                       *(volatile __le32 *)srng->u.src_ring.tp_addr);
> "
> 
> But the documentation clearly says that the case here is one of a few rare situations
> where volatile makes sense:
> 
> "
>   - Pointers to data structures in coherent memory which might be modified
>     by I/O devices can, sometimes, legitimately be volatile.  A ring buffer
>     used by a network adapter, where that adapter changes pointers to
>     indicate which descriptors have been processed, is an example of this
>     type of situation.
> "

Oh, my fault. I'll fix it in the v5 iteration. Thank you for the response.


Best regards
Alexander Wilhelm

