Return-Path: <linux-wireless+bounces-19852-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B06A5464D
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 10:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BAE8188CB55
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 09:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E69209F52;
	Thu,  6 Mar 2025 09:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="XmjbnpBh";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="HkdCY5em"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0024c301.pphosted.com (mx0b-0024c301.pphosted.com [148.163.153.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFCD209F35
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 09:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.153.153
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741253339; cv=fail; b=VUSm7jBIC0M1R2PXTkdXDWWjwdXagNLT2LdmQfug9Iho/zMyN79/VjpPZ1CLg4FHI4wudMxgt1K7yE0PvP+r0rplv1DChWwYtiHy01sn916fRz89p4XBrmKrd41wqphBoNTGEt4ItURb4odWhS6i9BHDi3eZeRLDDKz1S2qQ0Zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741253339; c=relaxed/simple;
	bh=fYO+TYNILw40e0eCoJa/x504yVy6jZLk6l8DeyUF9Iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IdgMKSeJ5OMd1Z4LCa08HEbFU6OZWDNBuejnmGolGlim843uPUEXWonybEKaIg9BA6Gnp7BlgOODkII98uDqyhDzob1Ag0kQYCREGg0lASp1zSNzZPdxSfwjb+bxzDVKr2GvaINVoTHHjT+uYR7UAaw727Ur4NwGXtACA2W0GAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=XmjbnpBh; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=HkdCY5em; arc=fail smtp.client-ip=148.163.153.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101742.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52686hkx014379;
	Thu, 6 Mar 2025 03:28:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=yjYewhDiWR244kT8cV9L1fFpcQAFhz595x8PerGYgGo=; b=XmjbnpBhsufQ
	nUYRczN9u8n21/Lpra3yIlUHS8malPdygZ8n1f6EcugvhwXgjyXOymdGc8QywOcs
	t6wawag2gnzWXWWBzrTxljg61BxHRsRGeCeLPWCouFMqXyOjimxyoZOdlIEoFecV
	0fwj9UrjnLcFuUXXTNVBj4cWwvvO3ZNldFeHDZ9VtY/c9UTR+XYr8ijZknK1mUKX
	U7K2++iIxL430NheYmwZhJ4VTFonN1Xu2Fcazq1aG8hoJdZgATuzeJJPqq2sW47X
	0CxhvbL3BdgjFqXeLAIMMs+ErWmCf6vG/CO5cnIJ2moehLJ75VxO8+ArEedaHZmf
	0lhC6hNs4w==
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 455qchn4n1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 03:28:51 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e92cI6FvJRXO6HS5YS4/0K99GQXBg5/iB/f4xjkS2gz43w/QJe1hpT24A0WwylnCW16vx1PM1aPPVHYLzOa+KzSoa9Tk91qEN+zlcPW3GjD0qgHzSKtUIeLYuYi3ynCqK+viLOpo5HJ2goGyKQK+Mx9VKY2BUje6yzCiNK40KufEprRfSB5N9m7fp4b+yJ7CpitGk9dKWaB55OluY7Z+zT5IjaaSEj4iOif6hIZCgnx7J5U7wX5cuoQp0gClGOgMrW4htRnM9a5OdR33Kr1PlOBRPSi1u+dAFrXNyiYiypkjIRr3aY5Hjo05oFJD9d2q4GoUFdhkSbQuVD0c/FBq+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjYewhDiWR244kT8cV9L1fFpcQAFhz595x8PerGYgGo=;
 b=QklEsOGYuSC7kiC/K3uC7Esz1V+rfscnzQjm0yZr8iDYB40imw31FE34HwGKsy0lzQxZjhcjk4T/C9sCWVOAy52EWyviL0gJJ6lUwK05vHlw9CJdUobKus9/Kbm8SI9TSrnh2dMYkthZ1yGnJTVUdoRbxorv304NDskNLbF+iLnhjLS11dJYMiI3aJG6tJGEgKX64u/6dzSwF6X2vPK7R94Lt2sNABfwca9F8vvo/A2lf9dumrHQQ1iEPki/bd/RH92NtNd580w0qKKA5bhnmetjtm6BSgTqLlIrV13Hre8QaknoIfO/WVAYIv/c7pNn0avl4PYdwnQIEKsoTtpGKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjYewhDiWR244kT8cV9L1fFpcQAFhz595x8PerGYgGo=;
 b=HkdCY5emue6qH+rCwwr0NMrN6FlDxS7jYdy965NXwZT15PE0zOKG37wNN1FvUVCAwdZyBOwA+L8gc9HnJI1yiYsetTtXM3c7lSXeMZVTNk+pRV/zOljLWupGBH9Ax9W9BajzA/bmN3eH5bzZ1wpyAINM1vr5JjDL2IJJinT/TGc=
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by PH7PR11MB6674.namprd11.prod.outlook.com (2603:10b6:510:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 09:28:50 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005%7]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 09:28:49 +0000
From: =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To: linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH wireless] wifi: rework MAINTAINERS entries a bit
Date: Thu, 06 Mar 2025 10:28:47 +0100
Message-ID: <1988936.tdWV9SEqCh@nb0018864>
Organization: Silicon Labs
In-Reply-To:
 <20250305201757.6abf00e86ed4.I7c86da443038af32e9bcbaa5f53b1e4128a0d1f9@changeid>
References:
 <20250305201757.6abf00e86ed4.I7c86da443038af32e9bcbaa5f53b1e4128a0d1f9@changeid>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: PR0P264CA0189.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1c::33) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|PH7PR11MB6674:EE_
X-MS-Office365-Filtering-Correlation-Id: 680881fc-3f8a-44d9-b4a6-08dd5c914d90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?8G8SkKEQLG9yW4syb9KO3caHwRV1zMmKdhc2dThQZ3xejqmIsKs9fr6sXt?=
 =?iso-8859-1?Q?SWZ/CSV0Youhb2VZz8QDZ2f7vHW+goh8O7VWJMh0vpdM6RZx46cyV8lqFd?=
 =?iso-8859-1?Q?27aNqg0KFdtwj49PdACjrnatTYIsB1aIXLECIz9JT23onZrM9qRgAHcf5+?=
 =?iso-8859-1?Q?Ej6ZFDaxPHFIRwhGEO4QwUuflmPVT3z5JxTQMiMqScqUOH7rRFDkY0/8h8?=
 =?iso-8859-1?Q?iXsCxSd8AA8PiSL2M0msa364Jno9Nl1pYzl+RGoyxdBkxsN70zQX++IcJ/?=
 =?iso-8859-1?Q?/fzPMPw8VijYOAs7Qiz3EOwCdChgk6wnq2AW/k+9ch+DIthXPTJTLyvIYJ?=
 =?iso-8859-1?Q?Wy2UO2/TFvFk0CgrsBt2GVwAiRR8QxALXUhSOWJELJgKisUO+yXFZb2P/0?=
 =?iso-8859-1?Q?rqBSaaGtCWaJyFHaxZ6wRkBmidFM0h1OHEdAMXco2Z4zUIi/gkjzJ5x8M+?=
 =?iso-8859-1?Q?EIpfeWMqpGOu13HrSlzlGuAtUJRz+4nHPJd4kC6orZ+cISkacs2da7zW90?=
 =?iso-8859-1?Q?P1H50jPA4tLlhaAicVUzU7+pDbVDPGxm9xRIgoO/pE+WPq7CGuubae8Nm9?=
 =?iso-8859-1?Q?XsJ1PuSG/Ejc39xQ1K4v7lFlvCJla7YvBiLhJ3NDNFhFL7pPA/Z1DLyOxx?=
 =?iso-8859-1?Q?taByo2pWi8bgRsSSyKnnVjHBAy1kshcB9SAvimbavCyJ/JkMnzLx9N5wOG?=
 =?iso-8859-1?Q?x17shhb6NPSVehsHEB+EhzOSRp0IhBzcTFlMGaUpcu1GZYHbt1QnEJ4aUd?=
 =?iso-8859-1?Q?wL9MM+kee5a+lB4TRcMYXWlcHHOXUdhPliJxCrSnj2iEJqUhTOzvGJhaJu?=
 =?iso-8859-1?Q?WHQgjDTvzUeOM0xRm99jsLKYdNpF8SFFEb5terPC6UIjGch1YWeyk0hG0H?=
 =?iso-8859-1?Q?z75FkzeSbIlTv+9iXdgZV1I153NoILrk2YgzOp+iq3zsz50SHyaVkX7ai+?=
 =?iso-8859-1?Q?ls+WcUxL/BGP+PHx7uSrZ/uatBWh70AGzMVchRhxFvv4qfFklK7q3Qey9p?=
 =?iso-8859-1?Q?s+uYYEr3me6nzuT0TQgq0fRMpML3J3pPHg1bYa6Eg1dLalSgohYKYs+K8t?=
 =?iso-8859-1?Q?jtpkLCBC33eRkVbRT3yClOQoizLAz/jQeBTz1E97fQfRTbhEJz6yfBZM1a?=
 =?iso-8859-1?Q?+9F4xlbd8EcgctVbpPKY5p2hS3ZCc//oXRZ+4zu2SJEZsEvF2FgJU3SpRF?=
 =?iso-8859-1?Q?32/Vel+/9MhlJh8DE3hvAyyc4rGy4WUFTmbgUdqw5L+V0ti+CNPHqD1/PS?=
 =?iso-8859-1?Q?ak6FdlkhzHIpRjgMs1dklkC42DRbbWi0ILpCNjadSniqH4Cv3v61ayOFOd?=
 =?iso-8859-1?Q?6Z0IcStbZtfUxBErBKaJpUjdv+jeGruy3Ylkd4lxfLxjFUmr8+cCQ6e+0U?=
 =?iso-8859-1?Q?0sr3mSJJLtBRdi6QR1IyONwG8N+W+s6JxRfG7e6z8UbxAhEa9eJDEA7AF7?=
 =?iso-8859-1?Q?ARmXTaTLJDI1O/Sv31AWVzZtmujE0B1lEWga/WpIPDrrGfCpepD0PR0ILN?=
 =?iso-8859-1?Q?AVQ7vzqCaU8wNs53MFYybP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?5Q187GJg6iWu0IfL26oJUAy8oEVIxlxzFZPceOoXnAwEciMB/ec69On6zI?=
 =?iso-8859-1?Q?NflRymZZx/zODJMovmYbbkd6KH6iptUNY3T+WRkaW0OL7CVNNaLV6gMmWy?=
 =?iso-8859-1?Q?8B5aNb5R8iHPGtyjvAdAAH9P43RkdVe05RebKgwwbl6PfOqaJyC3skOshK?=
 =?iso-8859-1?Q?R2U8I7RDcCfOlFkFFK1oLIgbfiF4AnFONaPKASo7P3dDopUJZ8aoEPxYNW?=
 =?iso-8859-1?Q?uc3UFYYcCKojeHFcPITVnAC02iywA2xZNcoANWOW1SVXooALbFeH5q8twb?=
 =?iso-8859-1?Q?EAfYI2ihPycoPoWLg8T3bS+Ep3tpxsIhpcFKHFJrWphp9eQi1e9Jx6gSyc?=
 =?iso-8859-1?Q?CcTHLDo+gHWBW60HaX6NcYaVj7Y6IdMqLEPPeuKCTAb0R9OZwTtLnMrmIZ?=
 =?iso-8859-1?Q?3epKcnX+kMJpeBV8Wnz6olX3/aa4AWilVy773RdQkhM2pjzCNGeAWOSlqX?=
 =?iso-8859-1?Q?g9gBLLJeQT+bCuOMTwaqU7j+VPQ0VR1cD4zCbefqPfMxQnadY713JoNXv3?=
 =?iso-8859-1?Q?RoMW6fI5tbwgp42JiCnZLpw0+M8U/i4ApEAlGf4NSTXu0ikBFrJf0Mk6/s?=
 =?iso-8859-1?Q?B3oLmDDmfAHWldA1Al6s/1FHv8UoARjKxkvJI2NzW90+9KjC0ALmsVlNOs?=
 =?iso-8859-1?Q?8UnvyC5zAKuZgAzNYQE60nDpG7qrc8Fm4Z2sNQk4UrGRgdiWWqzNJm08Cz?=
 =?iso-8859-1?Q?Iy0NG2gx/dR7x0IFCv4tzgkTERUISr4TAbg9Fk5mx7fZSFMmLmSbGOMenH?=
 =?iso-8859-1?Q?llQWFxTREavbmPeHYlnvSos5VeQFd3G4D0sVbVdxRep++UObBQXyCGvX1r?=
 =?iso-8859-1?Q?xg8Fqe6UVY1xODz5+EVPOCsFhIwXm4w48F8Y4QOmMJ4fViv7MCJVv4vcPX?=
 =?iso-8859-1?Q?TIiblOxw0cibL9iHCWAjfkKvZPJglDOj9i86emC7QpdfVmEGETTQGalDNU?=
 =?iso-8859-1?Q?QBU5qBSvfiO+K2jwBvFubpjjNFXhYYLn7VWRzxZ0PTT8XfgVjJHo71GkCP?=
 =?iso-8859-1?Q?NQISNt45CWIMlD+OlARRRnM9VxkjM5PdCzh1LDEOKi1E9PzrGxOYe/Dy92?=
 =?iso-8859-1?Q?T8CxDlSe/HEQI/BJa4I1lAgVXfO6Q6OLpkM0a/OdPTcqe+ZNUsWsEzRTWX?=
 =?iso-8859-1?Q?cs0ov7lQ6Sr4EHlMIxhIHPmK9VLP2Ts4fXkSIj9tu6i5bPgml0dgh3p9NO?=
 =?iso-8859-1?Q?CMH0kGBoJOW8eqDNaiyETTzNFjhUIX04vcyV0B01F2TTYPKcPuWklYdh3G?=
 =?iso-8859-1?Q?fW+b1GjeQ8hNgmZwv2c3yVIFJyjWWp6VrvW9VAjBeP22yyI/nRjkIFQ7mT?=
 =?iso-8859-1?Q?DV7QXnctBYBxD3lwPJo7nkwsDEFgdvDPxig03Ga16asv0nWjBbB5o3vwoy?=
 =?iso-8859-1?Q?pG8ngQ8hnBM9F59v9SE2Tqa9A9flpmOSHiF5VnwWU6PuxODCp058ZnU4sT?=
 =?iso-8859-1?Q?BeP7w08zeQ0/n8xSN1OF4Xn+iahX9pWr1tMZTZ6W3SdXMeW9DhIGTB+GzB?=
 =?iso-8859-1?Q?FCTWV2mgkyv0sUSLbUTn1v3Uf8LYltYTwh4J+qeUcJobNFPH1eicxBg05H?=
 =?iso-8859-1?Q?+VKX73tLd+/UTXZxZCxm7sZmmHjM5ho/vOMWiTi8YZHCPx/VC7vXEmzTWJ?=
 =?iso-8859-1?Q?XXjFnrnPrsnjrO1RuNmt30Zqikznnytwnu?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 680881fc-3f8a-44d9-b4a6-08dd5c914d90
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 09:28:49.8885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +377ce/tST4Qv3VOh50Pj7UQjtvLGaMeqLrfmjp0Sgc50jwd7yHcUfTaIPEL/fSZAYFIE7PcwVV7JMyM9KYoHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6674
X-Authority-Analysis: v=2.4 cv=DPN14zNb c=1 sm=1 tr=0 ts=67c96ad3 cx=c_pps a=2scX5b6JGDBY9+deG5t9BQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Vs1iUdzkB0EA:10 a=LLPZWm0_0O8A:10 a=i1IsUcr2s-wA:10 a=QyXUC8HyAAAA:8 a=2AEO0YjSAAAA:8 a=5JAyhr2urTKY0jkHAggA:9 a=wPNLvfGTeEIA:10 a=d-TXpq5eZF0AJmg2YLt_:22
X-Proofpoint-GUID: R0E5TC6ETu3RKMm92dI1MNLvMWeAs0P9
X-Proofpoint-ORIG-GUID: R0E5TC6ETu3RKMm92dI1MNLvMWeAs0P9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_04,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 adultscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 bulkscore=0 phishscore=0 clxscore=1011
 spamscore=0 mlxlogscore=995 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502100000
 definitions=main-2503060071

On Wednesday 5 March 2025 20:17:48 CET Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>=20
> Since I really don't want to be CC'ed on every patch
> add X: entries for all the drivers that are otherwise
> covered. In some cases, add a bit more to drivers that
> have other entries, mostly for the vendor directories,
> but for libertas also add libertas_tf.
>=20
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  MAINTAINERS | 36 +++++++++++++++++++++++++++---------
>  1 file changed, 27 insertions(+), 9 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7078199fcebf..4189f59ee89d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS

[...]

> @@ -21699,7 +21717,7 @@ SILICON LABS WIRELESS DRIVERS (for WFxxx series)
>  M:     J=E9r=F4me Pouiller <jerome.pouiller@silabs.com>
>  S:     Supported
>  F:     Documentation/devicetree/bindings/net/wireless/silabs,wfx.yaml
> -F:     drivers/net/wireless/silabs/wfx/
> +F:     drivers/net/wireless/silabs/

Reviewed-by: J=E9r=F4me Pouiller <jerome.pouiller@silabs.com>

--=20
J=E9r=F4me Pouiller



