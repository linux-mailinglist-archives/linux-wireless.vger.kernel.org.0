Return-Path: <linux-wireless+bounces-26965-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCE3B4189A
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Sep 2025 10:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6ED956097A
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Sep 2025 08:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7122E7BBD;
	Wed,  3 Sep 2025 08:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="VLe9ldDZ";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="OlooiLrD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7371719047F
	for <linux-wireless@vger.kernel.org>; Wed,  3 Sep 2025 08:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756888316; cv=fail; b=AlE5oUIGO2T+oHxxzu60MzfF8+zP6SaQ/W7uXos74Nuyt0g1c6M/3YWkXMeIM6zlhychwEbZqV6gqpVr5A3P1o7arROgedNQ+7+kET/HflD7gdZN34ugBvHQ6YzMW2wXYm9m8XtnYXdUZ7v6TCtIjJ1T7Uy7IyNowmCBcp8PrCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756888316; c=relaxed/simple;
	bh=g3dlvGBT50QTvwF47plABE6cjcE+WHY3iy2RFa5eRVg=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=deZBJDaQ+ao3Xz9qlblju+FHsAu6UC7Ae2Qevw+hYGkxhQ3t1wLt6TJ+WnXzIiiGMpg1xcvDR7joAwd7nSMIDbYDL+aibHqrQVGWS1gO65wT5lJoPxASYsPFtANxhyKScvPmWN/a3kDbyUN0M200cEPWhuPdG/JSES1ks3TMSTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=VLe9ldDZ; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=OlooiLrD; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5834nERW1873499;
	Wed, 3 Sep 2025 10:31:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	270620241; bh=tusTmFChqnOQaZJBkYzIUwYZ4wTS5ZVotCA3YZ5Mdxo=; b=VL
	e9ldDZNwzNiI+SmxgJVhvKmxRY2dzBhw5yzD3/eqi55OR/H6kYRPp75kaGyac/6k
	5594VUE7lcLPK1HJtCb9ieHhlwDOoOoDrnp5kENXnEL2O+YK1wrtsVzqXGyJY2o9
	pNwUiO09RMUYQXsvG1XSaQ2Rz2FAgGYavJ9mP+pbFlGAJHLSYLpXKmP0ZJglQEok
	XS1uljar7dxKYvPyrTNXVo4/Gv/0txg2NnLFa/yUULXSsZPmO01H3xufvFTaAAvK
	y0d8Y3v7IXzi8IDHVndkXIN/vFc+AbBSPmldng2uJCjX5qtPZ4LZhxXRH1I2BLkh
	SzsNVJjOGfHNqY3KyCUQ==
Received: from eur03-am7-obe.outbound.protection.outlook.com (mail-am7eur03on2133.outbound.protection.outlook.com [40.107.105.133])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 48unnbkrj8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 03 Sep 2025 10:31:32 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KbjXGfcFuE8WjF+HwgFHvo0ySXfeKRf1Brg3TPj8VzJQl8LLnyMtJN/M3SM2kbswtqQywJTb4zofx47J7iFHludV+ocNWaXEuS1ZL/z3uFdXdgCGvr1IYNqoFoPowmj4WlZBpILlrySsn2DfRrZrhOiIhCAfRnj/bwaO2vk7m+TggqYDYIuulGRigDltrPbA111YP3M/AkLb37Gl3nhIUii8bbTU5ED6jU4xjAms8S4wjq9Dp0MxZfjbzmPEqYbh3B9qWo5EYqEF53OtxRJs3VeagXvxeA6m7y4qQbGq1cbDpUj3O1TPWsSBTmwuBG2Cf+W+hd8alyxTrsewgH2saA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tusTmFChqnOQaZJBkYzIUwYZ4wTS5ZVotCA3YZ5Mdxo=;
 b=HNDpxuDh/DXVstbZ0ObOeWkTnBuOfptmCNxmV5PJgVD0CK9SyXg/BLDr5onWmCK4pVRdCBGpbhatFXWXrofxpIboCZtx2Tk4Hgc248+1HjVBs/5ukoXRLtCbnS5Gfm0LrX0WKQcSHjQyEZ93Dj2LS7nF8kiW+G9vH0+ROH+B/yWdmX77mz5zjjmogYUVQgy6OWVKRk7a7S2VmGnXIaKuTKEdt4XZ60uCvW4lTpR0figXdoK3dL1tsOFSPhbcIHRfll526SJVk1qqMhUeQ4/k8SXhvceSXvtD/1X5NOKG8eQ7udhRbf0VxfYdUtNIpnV8LHCE1jhqdcPwtzbydDv59w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tusTmFChqnOQaZJBkYzIUwYZ4wTS5ZVotCA3YZ5Mdxo=;
 b=OlooiLrDIYRdqj9+QkwD5/imyBQmxsm6QFX+OhgeFTHGabLdt1e2jYqI1tOlLfJve2KqZZod+kpjdcbiq50ejHHyi6aMUdDtaE+pn1cVt3vJNCDhpbYAydEAofIjbIdeciApG6uPX3ZhRPjcSScBPNsQb9XiBKvWyXfeWYX+2Ok=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by MRVP192MB2804.EURP192.PROD.OUTLOOK.COM (2603:10a6:501:59::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 08:31:29 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 08:31:29 +0000
Date: Wed, 3 Sep 2025 10:31:23 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: ath11k: question about memory-region
Message-ID: <aLf825sx7W2S4Hlx@FUE-ALEWI-WINX>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.1.4 (2021-12-11)
X-ClientProxiedBy: GVYP280CA0030.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:f9::11) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|MRVP192MB2804:EE_
X-MS-Office365-Filtering-Correlation-Id: c8178dde-4f05-4cce-1f47-08ddeac447b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K+Hf5UnZFYfq5ZWrAJmYnMpQxvHdRzx+T5yBGa+ZQOoPC2buTuocgT3vReQc?=
 =?us-ascii?Q?TSIbHIF0HzyduK0o/Ek8MSoYKLiQ/vCzkYaOjBNrVqkB2V+MPwgX+oBJQdA7?=
 =?us-ascii?Q?p2e/x0GYnCbwmU2HaL4YKoAeoQgqD2Zd3q13VA4+BKnyG6BPvPsKt+SpsWWU?=
 =?us-ascii?Q?aQ/YrzCxVKRxXt9m4LwyHK715rVu3HxdXTt+rIJfT+T1GGtTqRPWymaLuWbG?=
 =?us-ascii?Q?bOFqCBm/mVPR6ppGiJ6sMx0uKK2OD5YLGg2/hrQC24MSO/+IlJhl2MSOQ7WS?=
 =?us-ascii?Q?oukvbXQmlkEGdR9BTAumLTpv0f9cZwNa8E4nwNx2KrZfNKUqtAcSk5XJeYfv?=
 =?us-ascii?Q?ZfpZVZujvuXN3eLQj43U0zhEtXAi/fmmQWSLxuS5dXtGJ36KYH+i/xhee80v?=
 =?us-ascii?Q?XxesDN7A7h2aWIctkFHW9IwzVyF1Kwla+XO1955ybwY90CAiLN8cxVIQPVZX?=
 =?us-ascii?Q?PbvRD5g7J6HU79eCTwSVK/P7bTbVEvyc1iNrGv0MfBOEL2pHF4UTZq9PJd74?=
 =?us-ascii?Q?zCMwHE6ugwhm65YEKUuLrIY9yxc/OfzavGTdjm6ppBD1DynQq6+dMO3ClSw6?=
 =?us-ascii?Q?AfebjQNTGEdjuhN7VPuK/EKdpGyncX7BuEICSZPhSfgS5FKOYL61/Y9K9PjI?=
 =?us-ascii?Q?11XHYScf67ynSPKDRvLBA0ljJgOtSma0pBDZfuccY61deQEjNlw2prmS2dQ6?=
 =?us-ascii?Q?yGzEGKb6zrpG5rUJ7DRiJi3gEWwntJylmQiu/2NY/+QNoIb5zxDAus132PLO?=
 =?us-ascii?Q?KUjTX08KroVqux2RYSKQBNB/glNn0sK7uP3snq1P/0kFuDnNzBIaig5x3ITC?=
 =?us-ascii?Q?WxG7iQthsXBcDxooo5RP0GNvkrVcw1qv1hEq/NimPmu24tJoRCRTyfp7o9g1?=
 =?us-ascii?Q?Gl0B6Ukxjj+rZaPof6EF2+wt6hqpcEjwRYk8P3FNyQI7YE8Q/nm0k2ft21RG?=
 =?us-ascii?Q?pMdRNzifFk77hqWdPVyMPJSZleb8ELevh7z+b/f1JzAHccgwoNdEDMnb+qrn?=
 =?us-ascii?Q?sWfYmGcSipOH+SzFo9byzdy0235o0KoCgpp9ztTkp5vt9WYbZ+FGnDCQ9RRr?=
 =?us-ascii?Q?IgD7fEQFP3a4okqkKPZ1JUYRuQ7E5fe/+CWaVySWdYsUvDmW/ELYuzNtzawU?=
 =?us-ascii?Q?5j2gwoo0KfS4Iogec4oYdfQfMcZNP6naUBofRNE2DA/4BqoMW6P9okYPfjD4?=
 =?us-ascii?Q?H4BqlsZXqejKcj2f7gS9XriJNzX6UTX3s2lng/4NxVFGW0Pv6ey+mrMajrvg?=
 =?us-ascii?Q?xfXU8N9sOPCv1hN+xv5rS1xqZo8F5olo0dGEjXb4s62vckNhcVSnAIpfcmHE?=
 =?us-ascii?Q?9iyW+lioMKrHQVUA0r9simsHu7qHpwbJcJfqn1bptyBfSiuVP9Qa7o3KpA3N?=
 =?us-ascii?Q?G7wT7U4eq5mUYP9MQYrZvK2SHEu6NbUaQYLVebk29MJP9l8sO4CMCPPbQ/Fo?=
 =?us-ascii?Q?d6VxlUgONJc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ONNW3hIbbs+iw309uLYOl3To59/f3BD6L/vgSh6rApjLRdg09eYo+COuu3nc?=
 =?us-ascii?Q?1+4LHusJVhcNWtG0QBbMi1yfn5tK+cs3jcrDP1uDQGeEcV+tYyn82HfjmNt2?=
 =?us-ascii?Q?gbVsRt1jA+Yhyd1qKZ0bZA521tFNiDfBH6uVfpVV8vaYvXP0M4Bi4y73fYnH?=
 =?us-ascii?Q?k+04hU7WAN6lrdtxfPuRI8kYF++vTtY8kOyHtQ/o02od3pq0e1X75QHpruOH?=
 =?us-ascii?Q?pd/I87htpLo+NU29RQm6TMnQV9c4jOBGg27k8cFAczsWuRO0lfCmyRWC+I7m?=
 =?us-ascii?Q?nN3S6YQtJhF4LdR7jCk7/PziqSnKoQISvZEFKe6Y1TOwZKCF8cmP9/13135E?=
 =?us-ascii?Q?feTz+20En4QZq24hTw06/F6UfqdL1Q1aJ6XsFLNKaOsg0IFjlmXSt5EuuoVk?=
 =?us-ascii?Q?NIJUEFmIm5CyzOd/KR8c87WT4/cLnMaoTeo+wAxDIOFCSRjOOV0BlPBuPzED?=
 =?us-ascii?Q?lJ44t/XsImt49buJiKzdG/57d10xLdxOx9MOd6ajUp5WJaKV+qzso3DgkgTT?=
 =?us-ascii?Q?py5OaNFB3i2kaItl1RGVfJGH26caTjhfWe4U8QdV5HbDO7aEjA9N3bp6L3Fa?=
 =?us-ascii?Q?pw2NcYeTsI6uy7QEaKBy5MmJNXoRtGnxLHVW4CMdCoGOZc0XHHNqgAx/NuS+?=
 =?us-ascii?Q?efzCJLV6TVI0b3fp/JvZ3piMzn1gYFJSP57n86ZMY0h37zOj9I6xGHAgDnaY?=
 =?us-ascii?Q?WQ9BAhYlhKsJt60dlcqmmf2tF28UKg43Y8jTw2ylFtqPnzFMbpJo3aR2QIUa?=
 =?us-ascii?Q?iH6yfYXgGRFVuTFof96f4KqIp0yDrwcF+74tne4FG2jSZkUsKUmJe8NILYQp?=
 =?us-ascii?Q?wZfUo/78AAHp/Vi0jGyUpFfRsnFZ1WZP6hllxZu5sBRQtKR2uoFZLrfGoF9Y?=
 =?us-ascii?Q?3J1wNmgIyAEMQtDCkqprdt+6YxbVY4aG//aXGfeazxlodpUwlzXSL2lTIZnw?=
 =?us-ascii?Q?7Sqt6cX9H7iA3xpJM/dCFJOlneOoWyLoDlMVTT6sfAyFC8KQD9dfcqaeMz87?=
 =?us-ascii?Q?u2ghfqNTiLezJGQ8rLuzdyFLjh4wgYFDWvhplwZvtOVHYouRI1J8IrVi+hwB?=
 =?us-ascii?Q?KCcMeOzX8yoUsLfA5mr/lyFCJNdhZk4JK2ojWkAoAroNdgXgS58YkRsiPAXg?=
 =?us-ascii?Q?lqxCs/EApWRfATkJxFMBYE9H+U/RTECKL3qVxPAx6VLFRMF8rpATFftLNuet?=
 =?us-ascii?Q?q3L2P3YU8DGwyLujZvLyVwoOxBNLlQ93HV3kFFOxAuIQ5oOHF8g/kUe7dKnA?=
 =?us-ascii?Q?lxHG8IHKvzz76Z10UAIdg7ChpQd55SoyulZwNV3lTRoTbiBphb4t9aiGB0kn?=
 =?us-ascii?Q?8BEcALQ5rIwwBksV0THghe6UlywEW7jNQ8GkjbqitHPAHuSYG62F6fr8Es9V?=
 =?us-ascii?Q?b3CZOdH4+Vn9K43T2bfUMscOfLMGQJD3u7nBRmyYPPEKmeBxszixEADm6wOD?=
 =?us-ascii?Q?Prqx3KKl3qAiivxhiVbC8tXC5eA3BZhpdPr9o3609aX7GO10bpXFnTB+EWIE?=
 =?us-ascii?Q?K0OHLoNFT6M19cMEmRtmM7F0xJLcTnizeoRj96ZRXXaqW8dwYJSCpYywKz1L?=
 =?us-ascii?Q?KHVYuaa2ZRdVxHKo96XQAZDmCZO6/kWSq5gKqkk0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BzUyYJ7hs8//oio02QG+/PEIkmyRA8SeoIhWYQGvz54eQ8V0y/BW9Lxte4TxeqsjBpALmflZZ8oYzomb62rx1KXr+Nr2Oca19RQJZv0CPu/CJIWHdhn4LYEk/3Xwu/2ihKDZwMGvt2Z9I9QbVTDlNqUjkkaHimIwuIYSE6E7upBQOmbXhjM+LPAS9dp+J4oHrygL1DQTE0Hr40rrPhgPIsN7fhZ07UsVH+HB0y9R1ZhpcRI5CY+uJWG28miM/vIz0v0oW5qLxjZmdVfR3kWMwNbRwWsmmIcneCo3ql5WpovPzyRVNb1R+l5FKLRLjOav4V7iD/nmRE2SLWirHDVlx36rU5DbGkEa+KfPb+gojkusbN6VfTC43aqZYZ+cdJltUrafjrYl+VNImmWjnm/8Ta3sBwRwfHJV/sxvcJnmdHpn7zmmN61sITgJ+ddXEXr/yvMDoj3euGq53nrSyrh+efbkkf4yl2iIbCyMznx8P6X/s2MQSSoCpmfEXjuwXM3MK4UkYWFCCJlJ24orwjeTXumrA76vGXg1gITM58EY/8J92aES34oLrBXI0vPA06c/sXdLNoGGBTw31dqCulTsOnkvcuTk1pWquLq9nLCyZughVr7torkY28DPcZjR6PY+
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8178dde-4f05-4cce-1f47-08ddeac447b1
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 08:31:29.4405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 50Rvm0pTnyxNRuPrZhYm8CCDej3LSXQoW0TQOX7rChVLpiCMQb+x1ovjGC7mlLGo35xPoIHE+MQ1+wUqInhMZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRVP192MB2804
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
X-OrganizationHeadersPreserved: MRVP192MB2804.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-ORIG-GUID: YfOrf0R1TOYw_rdb7i6ELLA1ujyuQIhK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDA4MyBTYWx0ZWRfX02uTzUYN5jl+
 Ko/WWkA0wLU3fVh61zk5sXBixoP/gHEOPbT5skabYwzgyTld+yW+1wPcXIkBHBjfNN4YeadoECe
 yfI4vyj6idMRZp1LDpJyxomU9PR7Rsuo0oGZaKMxe2biULyzU665cVucJOr8RnXrmdWVEY5c/ga
 XDHz4yjTQAj3Ysqxe2K8sq2ZbVteTSK7ycGNgWbOlkpvIXSaA1TQlgJ7jCakuJ152tfW5nLWEud
 dBtX/3NjBP40tlaSFGXtOBNmRZLVs7Up5N3C9szVorS2Fo0i6/ezz06p210sn5a2av28mUpXnfT
 ZuNDuD9fIze/B37InLVdubDyax8661eyf+MMh/qbkPJkR0O+aVAk+XLpKo73yw=
X-Authority-Analysis: v=2.4 cv=Ac2xH2XG c=1 sm=1 tr=0 ts=68b7fce4 cx=c_pps
 a=PEstti8cHjY5srQ4zJy28A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=8gLI3H-aZtYA:10
 a=nnYCWavfzEyUydkX7kQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: YfOrf0R1TOYw_rdb7i6ELLA1ujyuQIhK

Hello devs,

I have a question regarding the use of memory-region on a platform without CMA
support. Since CMA is not available, the driver allocates many smaller memory
chunks instead.

To evaluate an alternative, I defined a node within reserved-memory in the
device tree. However, this led to a firmware crash:

    ath11k_pci 0001:01:00.0: BAR 0: assigned [mem 0xc00000000-0xc001fffff 64bit]
    ath11k_pci 0001:01:00.0: boot pci_mem 0x10b272d0
    ath11k_pci 0001:01:00.0: boot pci probe 17cb:1104 17cb:1104
    ath11k_pci 0001:01:00.0: pci request one msi vector
    ath11k_pci 0001:01:00.0: MSI vectors: 1
    ath11k_pci 0001:01:00.0: pci msi base data is 0
    ath11k_pci 0001:01:00.0: qcn9074 hw1.0
    ath11k_pci 0001:01:00.0: FW memory mode: 0
    ath11k_pci 0001:01:00.0: boot failed to load firmware-2.bin: -2
    ath11k_pci 0001:01:00.0: boot using fw api 1
    ath11k_pci 0001:01:00.0: pci msi assignment MHI num_vectors 3 user_base_data 0 base_vector 0
    ath11k_pci 0001:01:00.0: pci num_vectors 3 base_vector 0
    ath11k_pci 0001:01:00.0: pci msi assignment CE num_vectors 1 user_base_data 0 base_vector 0
    ath11k_pci 0001:01:00.0: pci msi assignment DP num_vectors 1 user_base_data 0 base_vector 0
    ath11k_pci 0001:01:00.0: pci irq 18 group 0
    ath11k_pci 0001:01:00.0: pci irq 18 group 1
    ath11k_pci 0001:01:00.0: pci irq 18 group 2
    ath11k_pci 0001:01:00.0: pci irq 18 group 3
    ath11k_pci 0001:01:00.0: pci irq 18 group 4
    ath11k_pci 0001:01:00.0: pci irq 18 group 5
    ath11k_pci 0001:01:00.0: pci irq 18 group 6
    ath11k_pci 0001:01:00.0: pci irq 18 group 7
    ath11k_pci 0001:01:00.0: pci after request_irq msi_ep_base_data 0
    ath11k_pci 0001:01:00.0: pci ltssm 0x111
    ath11k_pci 0001:01:00.0: pci pcie_hot_rst 0x11
    ath11k_pci 0001:01:00.0: pci pcie_q6_cookie_addr 0x0
    ath11k_pci 0001:01:00.0: pci wlaon_warm_sw_entry 0x0
    ath11k_pci 0001:01:00.0: pci wlaon_warm_sw_entry 0x0
    ath11k_pci 0001:01:00.0: pci soc reset cause 0
    ath11k_pci 0001:01:00.0: pci mhistatus 0xff04
    ath11k_pci 0001:01:00.0: pci link_ctl 0x0000 L0s 0 L1 0
    ath11k_pci 0001:01:00.0: pci pci reg 0x3164 instance_id 0x11 read val 0x11
    ath11k_pci 0001:01:00.0: boot notify status reason UNKNOWN
    ath11k_pci 0001:01:00.0: boot notify status reason MHI_CB_EE_MISSION_MODE
    ath11k_pci 0001:01:00.0: qmi wifi fw qmi service connected
    ath11k_pci 0001:01:00.0: qmi indication register request
    ath11k_pci 0001:01:00.0: qmi host cap request
    ath11k_pci 0001:01:00.0: qmi firmware request memory request
    ath11k_pci 0001:01:00.0: qmi mem seg type 1 size 36700160
    ath11k_pci 0001:01:00.0: qmi mem seg type 4 size 3784704
    ath11k_pci 0001:01:00.0: qmi mem seg type 3 size 1048576
    ath11k_pci 0001:01:00.0: qmi mem seg type 9 size 8388608
    ath11k_pci 0001:01:00.0: qmi mem seg type 10 size 8192
    ath11k_pci 0001:01:00.0: qmi ignore invalid mem req type 3
    ath11k_pci 0001:01:00.0: qmi ignore invalid mem req type 9
    ath11k_pci 0001:01:00.0: qmi ignore invalid mem req type 10
    ath11k_pci 0001:01:00.0: qmi req mem_seg[0] 0x0000000040000000 36700160 1
    ath11k_pci 0001:01:00.0: qmi req mem_seg[1] 0x0000000000000000 3784704 4
    ath11k_pci 0001:01:00.0: qmi respond memory request delayed 0
    ath11k_pci 0001:01:00.0: boot notify status reason MHI_CB_EE_RDDM
    ath11k_pci 0001:01:00.0: firmware crashed: MHI_CB_EE_RDDM
    ath11k_pci 0001:01:00.0: ignore reset dev flags 0x2000
    ath11k_pci 0001:01:00.0: failed to wait qmi memory request: -110
    ath11k_pci 0001:01:00.0: qmi failed to respond fw mem req: -110

Why is `CALDB_MEM_REGION_TYPE` always set to physical address 0? Could the crash
be caused by platform-specific constraints and not the firmware/driver? Does it
make sense at all to use reserved-memory instead of small memory chunks, for
example in terms of performance?


Best regards,
Alexander Wilhelm

