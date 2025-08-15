Return-Path: <linux-wireless+bounces-26399-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DE8B27B62
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Aug 2025 10:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 722AB18876DF
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Aug 2025 08:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B82227B9F;
	Fri, 15 Aug 2025 08:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="w92BidxO";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="UZijf/90"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CBE238D57;
	Fri, 15 Aug 2025 08:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755247149; cv=fail; b=gfBaFEsINdysH+nF8TH/PZQEL1xFi+fTdnONX9GCIA+SmRXvnptrnaK5nySjCzkXV9hLR7E/uvjkIBbMN2anc/GhGYhx+lxrrlwi8gxmGf9rRDTsdV7n8DdVYeiQbwCTRteHlz3WRE/DR+qS1dfFVNl60q9HZQHFXHLKyMD0Xb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755247149; c=relaxed/simple;
	bh=v2Ow0XdO0nal+O84r2D/rQy4LltEolr4IY2TwcWku2w=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=QznnFwGk8wUhcekeS6gxTEj3iQaaUI3tZmNsoAQR+FJSzYkvdY5ECoURewFoS7HI5Ply0/2EwSiC3yfKXRaxjVtJDKiXO8Dgoyl37LqFaxvlUlhHGfW5COAad7WJscSmByswgQYWRmf4s02a90JOSp4bkQdnKJgLoRKQUrSgF9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=w92BidxO; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=UZijf/90; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57F5UI9O2729594;
	Fri, 15 Aug 2025 10:13:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=270620241; bh=v2Ow0XdO0nal+O84r2D/rQ
	y4LltEolr4IY2TwcWku2w=; b=w92BidxOzlJCciP9qLxhrtIN2FJN1vP9BXfioZ
	BCr1WIhtCRUR7ukhjJGRWTOAVsYbeTmN3yXI7RAhjiAok9x83qCOXTjM/YZZrVZS
	XstXkJGV1PpEAhWKkfMNEoxbQTAznaswxJVd6y8+K9BS643JWDAtMQpLdmep2V6A
	kzVbWzvsLbMhKVf4cJGRDwlTXCXRgyXzZHFEZykqpWpX1KSAmnoELXuoaTyalaPR
	DtLU+GKJT6SoLwlDyY49ZHWucc1mG2vVsd1Y4wVgOgXgYevMq6A0aW5JK7T/9/vZ
	PRt6qrx8vQPxlg9rqDU42NEokAFno8qBqoPX9HOhseJMDJHg==
Received: from eur05-vi1-obe.outbound.protection.outlook.com (mail-vi1eur05on2097.outbound.protection.outlook.com [40.107.21.97])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 48gb9ytrg4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 10:13:12 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ghkuq08V1O9rfeY0MMt2jzZJ7tTjT7Y2VRN5v4FF/80cweRPivqpu2zoerfGbqVcr5TUR20K09ZxNaWYVToFi1Sh95n+/AOqoy0QHY35fhvC8lvdTvUEaX2MC/WT4oKUtSQZdaCwGcVhpt9HXSq9EaDLgo7MeZxW7vZIRJ4Tw0C8BPv1/Bmpr52gekXaqn2bIUrsIt3jOq03R8Ty+EDao4UqEwj2yWpS3BD6Gvxj8tx/1MMj4cIibA0I6AQ8RHNjkzi7T0klkwaKHauFFlUmXiqg9J70FqlVuaCIHvKVVA/vg27QF2LeZBIKnaZJ+XcWxm4/6vEejoVsOJAzPo+mNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2Ow0XdO0nal+O84r2D/rQy4LltEolr4IY2TwcWku2w=;
 b=XFkT3e9a3u+/6RUAbz/GqCaI8wzBcv5gX8e5ovpfsmJFVVtI78M+0cMU0j0cYTN6G45aId5edwbFv7IPGot92AW0JSokVss3oRNLuw+p3X77KK1LaoEONNgqRM/gAxwA+5AQEt0J5F1W3nzx2qkEs+J+1ZcQtphjRuqYouRCrL62RAHInylEOoZf6jUl3b+IfeiERX0gogHH85BK04zryFhAMy5rpTp9Mq6G+S9NbTc65jSA30xwScGojvG3817y9eSsgeHucceqic/YmsyWakzG2iivUgrvrF1vfvVfLP9hJIDEEY0aJqil6s/WlFnOhg87SIv0PxFw3ziaw/vemQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2Ow0XdO0nal+O84r2D/rQy4LltEolr4IY2TwcWku2w=;
 b=UZijf/90/gSmPXBMQewffZ+trwBUuXTFZXwCdLm5THAAFGJJ9gERVZasdlp7VlBX7bShXifKLrCoVgk+S5/pQ5n9sqTEvLFngd8y8cbRCRW+L0do91uu2sQkncnJy355vE7sOJBOOVhlvIPva5qneoYSClUFRQKBAI3T6jQ3Bek=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by GV1P192MB2540.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:261::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Fri, 15 Aug
 2025 08:13:08 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 08:13:08 +0000
Date: Fri, 15 Aug 2025 10:13:00 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: ath12k: REO status on PPC does not work
Message-ID: <aJ7sDOoWmf4jLpjo@FUE-ALEWI-WINX>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/2.1.4 (2021-12-11)
X-ClientProxiedBy: GVYP280CA0036.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:f9::13) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|GV1P192MB2540:EE_
X-MS-Office365-Filtering-Correlation-Id: d3bbe468-addb-42ac-37e1-08dddbd39174
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUxjRE9yU1c0Y0FCWEMzaS9RUGlrclFHekppZWRZREN1SktQOFVhcWRWT3JQ?=
 =?utf-8?B?OThycjN4N2syWHFITlhzUXR5WjAwek90cUU0WHJoTCtIeEF4Y2dQaGlKbERF?=
 =?utf-8?B?eTE3b2w4aHZLcDRwcHJaZHcvckxKY1pUNHozU1ZyZG9yUTlVUmVGaDQ4SmdO?=
 =?utf-8?B?QlJWYmNZRXY0WTZVOCtuWmVvTy82MEVaMkhxL0R6MXdJbTcxZjEvc2lCbXla?=
 =?utf-8?B?b2J2YWxyck5YUXNKOEc2eU4wM0hIWlpyMlVYMTlMdkVNZFpxWTBveWxCUDNW?=
 =?utf-8?B?bFViclRYdHV4clVqV3huODRPbjBRbFBEcHVFZ0R5VUZPb3dYMDBnRllvMUpT?=
 =?utf-8?B?dEJGYWFPRHQxT2dMb01Md3RIcGtPSHVFTmE2Y1Z6R3pFY3lCWTA4ZUhYbllI?=
 =?utf-8?B?R0NHYlhJcDVoQUJveldxd1FxVVdqQ0hHYXgxZ0E0WktKY2FDeXJ6QlJTZUxn?=
 =?utf-8?B?V1FsZjE3U04yMmM4WHBjOWNaK3hNeEN2eVJra3FVOCtlSTdVdWlHdkYrMy9C?=
 =?utf-8?B?QW1aQmVZTTdzVWVzV0wvREM1SE1ZNVI2SlJhVUM1YXdTQjFFbWFiVDd0Y0ZG?=
 =?utf-8?B?bWxDeS9STHE1MkM3YXFQTFNsak52VlVmUm1SVzZWQitHakgrUGJJMVJ0R25h?=
 =?utf-8?B?eFNPaTFhU2k5WWlUNWgwelMrRzdFSDNMYkZtdGRJVU05a2x0c2FuR1Z3d25J?=
 =?utf-8?B?NmczdlJtWGdRKytVbXoxMnhjZlYxc3pocXRscitNelJaMnA0WGpCK0hEeis0?=
 =?utf-8?B?ekxKKzgzUEswSlNnYmU5TENlV3BuQ1g1a2QrQ1pSREtVOWpWWnBHZlVnRG5u?=
 =?utf-8?B?dXpJL2tHUDdVRXo1YWFqWW5uMUJOVXlGRXc2UlZSOUNha2M3ZlA5bktxWmRR?=
 =?utf-8?B?bGxuZm1Fb1g5dFEzcncxZE1CZ3ZXdEEweVhsM0JDQ2ZZWEhNOGxSVndaUzI5?=
 =?utf-8?B?a001MTh3ZXg5ODBSS3Z0dmgxSnVGemFMbW8xQWtkSUxUMDFXUmJHVExEVmxW?=
 =?utf-8?B?WTVYOUs1Z01UNXRUK3FCdlhOQ2dNaWxpeUxVQzUxRWhmdDdvcmJKUzN5M2hk?=
 =?utf-8?B?aXlRR0FiNmhleVEzNkVYY2U2VXdDbm1VWnJMSDZ1dkF2ZklWVGtrZENwL1pw?=
 =?utf-8?B?V1lnTTNna0JzbXlrUmpQeHYrTUQ1b05FWWovbFkwWHdEbUY1YkxsbVpzaDRU?=
 =?utf-8?B?NWRMM1Y3djk5TnMxRVZ2S1BLQmdBR205R3dpdlRmenlXRXVhNFFtWFJCUzhU?=
 =?utf-8?B?RktwdThFL1BiUmhaRllZUEJCRVM0RXYxekI1eHdiL1RvdVYrbzAxSlBRUXN0?=
 =?utf-8?B?aE5FYmNKTzUvR2kxOTVocUZPbEdUWmg5QWwrdFdKaU51bHdNNllCaXhTcjg0?=
 =?utf-8?B?WTVWMzVhZmYzZHc1QzhpSVF3cXNjazRlODhpbXF5ZUxqVTNBMnkzRW5GbXVh?=
 =?utf-8?B?TjNiVzV1NTN0azJzWnNwQTRiVXZFV0puSDMyalJHQmJrWU5MUW1jS1dBYlVv?=
 =?utf-8?B?RWFENmhpQy9vbzhVRmJ6VWRqVlZoY1BrVlZaSG43S1pjaUZjWFQ2NG1wa3VE?=
 =?utf-8?B?SkpDR2NSQjBSQy8yUGs1bmN0TFMxN2ZRem1iTkxOMWUwYVlFQ28rS2NVdnJj?=
 =?utf-8?B?aEpvS0IxQzdTTG83NFMydjhDeWYrLzNWbmpmemRxamxqVG5iZy9sVlNBSU1r?=
 =?utf-8?B?MXVLUDRkTC9yMFNVa2RnTmVhY3lCZDRNcm1WZ1NUV1I5NTJUdytVdDl4dVBy?=
 =?utf-8?B?YVZPc2ROeWNwQWw2OEd0b0VaZ25JOTF3OFlZblQzRDhPNnJpMzBzZ2JHQ0JY?=
 =?utf-8?B?ejhkY0RiVHYvQTFVSE1uTkx5RUdWNC9uVm9RVjRuN0hYYXRCRHpBRklIcmZn?=
 =?utf-8?B?RVZ2Y2lxazN4UkVzdC9GL2xNNUVGMGZKa0RVcUxOSEJOSEplV09scSt0S3pi?=
 =?utf-8?Q?qRxbaCcLBUc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFZOZ09QNzZRL1NqeXZ4dEd3Z2VzZGRsbkZZcXpjcDlJMjBYVzhoZ0VuSXpZ?=
 =?utf-8?B?enp6RmxIVEZnK1VJaWFUWVdPQnQ0NHFUbU5YN3ljUGJlbWZwWkhnZWNkeG8v?=
 =?utf-8?B?b1pBTmRjQVFvckl5WC81Z1g1YXY2VFFkd1B6ald5eTBSN2Q2aE5mWUpUVFNy?=
 =?utf-8?B?ajlYNXNydDRTbkY2TjVPSU1VMjNqSkpNMkhObG5WR3l0TVQvWW1PVDF5Z2hY?=
 =?utf-8?B?TitPNFkvQmZrK3ZldlFDODRyODlwSHBTZjhLalFUemJLM0JVbGQyQUl1dFpp?=
 =?utf-8?B?aUErTmVqUkZRZXZuUzdONGQ5REwyYmwrQVNCRHhtVDdmV0gweDNKeEREeDB1?=
 =?utf-8?B?MHgzMForNG5GVkF5clJFRGtLSW5wZ3JJUjFlYUhVQVBWbjhoR3J1bVlrTnND?=
 =?utf-8?B?Y0hySzduUVE4SE1EMXJnRzV1bjNPcDZsdEpLRENrWWNxeFJGd3hGSUNJek9B?=
 =?utf-8?B?NHJwR01JZG1taTZ5YXVySzJhY1dvdllsRFAvOGlXZ3JRRzVQNWRoMHgxRTV5?=
 =?utf-8?B?cUp5bmdFN0J6WUJsZ1IzakwzMFB2NWhBdjV0KzUyZVd6Vi9VRjl3cFRiR1Jy?=
 =?utf-8?B?T0xHUnVxdklZN1dYZUVRbDVKYUVoamgrMUpSaGNkU04zeG5oL2lxTUsyandW?=
 =?utf-8?B?TXl2bmlMbXdLQWhuTnRaWmRPZEZrN0kwbmVDUXIxUE5qT1RDL0xnSkRUSVli?=
 =?utf-8?B?NFJDaEFlWXZFWSsxZGMwMzh4Sk14TEtkc1VGSDFQTkdSN2hnUjBhcGtyT0RL?=
 =?utf-8?B?YnpZL2lpZmo5bGxUZE11Q0d5M01hNGxEMFFzNHRlNUJPMmhoem1rVi8zNDE2?=
 =?utf-8?B?a0NnY25Ta21zT3dWa3BJYmhyclJCSHlZRUFhcUxSQUFUY09NekVRZG1sbGF3?=
 =?utf-8?B?Y3F3Q0pwWGc1dnJGR3JxQ0srODExcGZrQ3pjSjkvcWZTcEM1TkZ1VlJ5ODJt?=
 =?utf-8?B?a0xXaXlROFBnaG9mWTcwUnY3bWZnWXN6Y2tiS0VtY1NXRkNNWFFIV3MzcXhR?=
 =?utf-8?B?THlIMkNJK0x6VDRqTnhNUjNPL0VCT1p5VGl4ZG1vM1dIYUNGY3pnVzIwU0VB?=
 =?utf-8?B?bk4vc0tScnY1Tm5XQ1FxWnFkSEVIOTFzMVowMlp3a3VlZGNjMlNucXpua3My?=
 =?utf-8?B?UmFieUVCbG1yT1pGbHprS01FbjZjd2lDM1EzaXFhclNyV1RlY0g1UVhMdzJ4?=
 =?utf-8?B?VWlDSVNoQWJuenFLSmZaU0FMdEFRdkp3MkxDdDBSR3pYTVIxU09EQjNqOU9a?=
 =?utf-8?B?NEdwc2t5SVN1blVnaSsrUTFYSnBUNGprQWNNVFNUc0ZlWDdXMExTcTRiT2FK?=
 =?utf-8?B?YkFRWVprdTRIcTRrTGZyeTdhNGxIQktPaG5kQUxMZDBwazJiOWw0NmdLVGZu?=
 =?utf-8?B?bjZWQTBlWDJETmxDNllvaHJXSDNFS2MyTWIyWlUvRlNGaDZMazFyM0xocVI5?=
 =?utf-8?B?NjBkQzRzVmNVTC9PRHdmY0ZUVExvUTFHOG5YSTUrOHRSQTdTWlluR3BwdktH?=
 =?utf-8?B?OVRLcWJKRWEwZGFXandPNjJIMkl6bWpmbEhwV1M3T0owb3ZQU2dYeVBFa0Iv?=
 =?utf-8?B?ZnFnVGxSMzlkUzJ1VXhxNU50dWZSVkltQmNQSHZLWTNzdWpMcWw4OEtsclM1?=
 =?utf-8?B?NUFjcDRtbEtNNXpIZ3UxN0hUdU5qdXpWY1lUa3N6K2Q5YXJRNEN1L3NKczBH?=
 =?utf-8?B?ZEtJTFBNYmlnNG95Si9ieFZTMnNjSmtnNGgrMmdFSklvRzQ0VEdKUVNkVytN?=
 =?utf-8?B?eHVhK0JjeEJtRUhnWlBnWEVlV3hzVDdWRlBhUzl2VStoL1h5R2FueEVRSGlH?=
 =?utf-8?B?cGo2azl4Unk3VE5ySUsralRmZk85ZVhBKytSMW02OUtyMTk2eFE4YXpZdmdX?=
 =?utf-8?B?cHY2YWpKQ2E3Qkd5TjZmOEo3enJHMmR3QnA1RW5DTm5LVTZWWFZpTDlCSDAz?=
 =?utf-8?B?a1cvTmdHbGpwQlpYV2daRmFWa01BYlExVGRXNFNrR092ZmZBcVh2dmNJUHln?=
 =?utf-8?B?WUxsZzV6azU3SHJDV05Ib3RydGRWOGpERGVkdytvQ1lGVG90OGVqTzRPYnVn?=
 =?utf-8?B?YUhvcldJTGFJRytpazJaZ3gzV01kNDRDdElOQkV3Q2VJcDZZQ29Hd2cvY05k?=
 =?utf-8?Q?dgEVLozkG+qOr4Hs1gG1/yWZR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LGIlSWC7sMvrG8giLPBR4q9gbpH8WmuxJbF3gu9BszLPKIs5LbQR3yairBw4+QyFTMQCbtjFXkE/DtRC20zpIJSrrhOKfOdOkIrVIcYwQJqQTy2g+ryeSevO2uKX8lqHQK19TO833Ixbw6MigDnFuSiPganD/c/jvSXT26LQOm4GYzzcJKsusRcN4XVaUMN6qoU/rnEK619ao2mhSdQqTsRL6OnGM2QkMOZ1DXn1i23k/eLhg7TaglFe6IHTCV/fiobemVf93jDwCuIWN5KjqfFJpEQYMMbuoUT2yi/j6tnzwDAVVqXrRWPBCmfPLFyc7yMhsGsrMxMPFlat84Y9BbzisnkhdpCVNW0ExEdDfDaojlgLpftardoj7zTMC0Hn/AfqD5XecfnUPjhda1in/zj4zgXQJE01BdltvyxI9NIgVkIfMxtcuqr3cb6Cg7k48WD6wZMvvemExr0rncJAMW/Zc98VUAeugqlRDYmBzhhRJtbPXvgw11hzfFbQQpUIHtN3YvnJLUIKG4JLoAke0eC7jDRj8MQNyP+hGQM6uuM0cYczRjz8N+L/e7ZmV6Lpe04HKdSp+rrBcAFMsQr+sNKe3EC3eVFQl5yHm4KIA+M390tgJG415B2k6u7Z8EEK
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3bbe468-addb-42ac-37e1-08dddbd39174
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 08:13:08.1921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TtS8V8fXbqxp2Agc5B7VNVmhk7169W/EV0FI8xB2UdhcNa2HgPuL4t2n7+19p2uq78oGHFdorepwm/Q/NJYFyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P192MB2540
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
X-OrganizationHeadersPreserved: GV1P192MB2540.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-GUID: ENL3x8tQ18dLEUnY7pG5s8goQDVc6n2s
X-Proofpoint-ORIG-GUID: ENL3x8tQ18dLEUnY7pG5s8goQDVc6n2s
X-Authority-Analysis: v=2.4 cv=H/WCA+Yi c=1 sm=1 tr=0 ts=689eec18 cx=c_pps
 a=OkXhrD8PvoFXecP6jN22mw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=8gLI3H-aZtYA:10
 a=aEozRzyYmvxSZNhvtMIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE1MDA2NSBTYWx0ZWRfX65XWZUNvy46h
 agdzLAE0rfA4ck4T/ZDrTlWhSjwtGyEJZbB3mpb1i508couvou6ZPlUYTOqMTF734fYwEGF7oH2
 HDfuB1GMLmlm/qGkXzQprFGe6kD+3Xutf+okrRBYiE4mbIblLeIbx+KSmDxnMLr9P7RSlBhSLzO
 ffOUEtHZcamGWfwD4CHqEVx9tZdXxjbEAQyJG0lBrDUI0xBd7ur4eSygJBJu3RKabN8vLsVxDMy
 5BRa/zwaYjrj5U1r4oYurFtSDlATM+o1x12HKD0tMAGCbzdTL9ycimpyy5ILlbWAqvVNeDeEo8x
 dQ1T9nY37MYVtdtmO0v3GhSFgiG+AqwrcvFlLniB5Ttv9c8gdRCB4NgSmNvfq78t170QMbfooEy
 B4XUqHzQni7bw2Ja1qz+XMfN6TVtFg==

Hello devs,

I'm currently working on getting the 'ath12k' driver running on a big endian
PowerPC platform and have encountered the following issue.

In the function 'ath12k_dp_rx_process_reo_status', the REO status is determined
by inspecting memory that the hardware has previously written via DMA.
Specifically, during the call to 'ath12k_hal_srng_access_begin', the driver
reads the value of 'hp_addr' for the destination ring (in my case, always with
ID 21). On the big endian platform, this value is consistently 0, which prevents
the REO status from being updated.

Interestingly, DMA read/write accesses work fine for other rings, just not for
this one. What makes the REO status ring so special? I couldn’t find anything in
the initialization routine that would explain the difference.

Could anyone give me a hint on what I should be looking for?


Best regards
Alexander Wilhelm

