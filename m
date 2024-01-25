Return-Path: <linux-wireless+bounces-2499-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8F683C9B8
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 18:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FDEE1C2425B
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 17:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF337316D;
	Thu, 25 Jan 2024 17:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XbQE9PWf";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="53b/FMiC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A352912A17E
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jan 2024 17:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706202952; cv=fail; b=uzR7oRsVonc/rWEqCfTI8U5fW/dwRRRE2O9OZjs4/jX6MCDN/+VTTZl8QX5BVwJtP1bcj4njnqNtt5LdcsUK2zU63WfTaFbg58vog8ooOwhn728wnlTeGRS9vNxT+BdgVSlvTn+gV+/+LVM+rr/QcJd8+ASRRtTCjviaBhZruCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706202952; c=relaxed/simple;
	bh=s75O3+FHcYT3y+0zKTWe4bcO4kUCKwS56yc8yO+18qc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tLzBaq8R5KOCZmCzWycpoZ14QYlJ7CDAfuTFKZuGbS5fyo8amXrHgFjT3E/PSoFQ9nntHIZrxFzVK0Uhw9g+xy8vkaPLpm8rmLrhuorgoOcxUm6CR/pXszx7VUbjZpZNExvna22E34j6mOmigXwmJ77Czqv76rA0Uicf1LP5ops=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=XbQE9PWf; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=53b/FMiC; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1706202949; x=1737738949;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=s75O3+FHcYT3y+0zKTWe4bcO4kUCKwS56yc8yO+18qc=;
  b=XbQE9PWf2amKMpMwxXj8+IpB9bCnkz4ABoUpOugH5FTFYZ9U8jNW8/gm
   l3mAqfpRXhpbYIYA3DdTnNuMyiks8ioVA3AVFJ7kPZ/lR6K54VQYEyDO9
   7xjUzzfsrQRG37vXtSjdccmykLeTTs/cWxqV41+3+V7BB2Mts90DkSyTC
   DIdrcoBZIXoD06/+EbEFoI0gOozaBq9gETYyJloNLDjP2V5DM16km7pOv
   dg91c7+4E5oiU+eCBXFMpWjc6lVG50XFzHnybFbpLHvy9tKc5eks1AJq8
   l2sPn5M0Ey1kHTR5bf2ZbNu6Ch/+83uR/MGGbj3p/c8i+U0qDReDkfolG
   A==;
X-CSE-ConnectionGUID: wwiXYVzMScOGmt9VI1fOYQ==
X-CSE-MsgGUID: uiMSbEJRRlClZUsqd4fqHQ==
X-IronPort-AV: E=Sophos;i="6.05,216,1701154800"; 
   d="scan'208";a="15785634"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jan 2024 10:15:48 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 10:15:39 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Jan 2024 10:15:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqTET9l8mrksMr04dp5bwUiYy8rjIspcmoKKAjqdsC413TO13uMvi70wFmUczgaH6bng1FnSFd+Lv69BWUSjw1kvNgLzrpq4rPuAOZwIpzIw7RkithReTg9YTyU0hoV4iW6jXLgu8YYcYm/qj4eEWCObe4FlAVXTD60OVWeKHjUPik02Nf76Gm298xe61UpVPgH9FtFzZFo/q/IAcrU+uPqqBqytrGid3/Hqy/GCYP8joxyu05054qx0l3xwYD6qSdGtoLyN9gT8hmOS+qanWk2lnDc7E2O+WPaYAyObV7Qo3L+ju+mFs5UI0F20nir/o3i30JZnUQwrrnY8Ok4PsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s75O3+FHcYT3y+0zKTWe4bcO4kUCKwS56yc8yO+18qc=;
 b=P6dX/IxeH4RqsgeCj5FEr5ykTdJ2O+rLWy89U/XXZBXesRV2ao/9cQ/ttS6hTZFMPiJ3Ni+LoVptdM7OTm4UwmL4UGmJ3VSgJ02O3rJKuwqMNqPvU2PoWSMC9w+ejT9eNft7YBOeFtrHAbmImVIuySNv/fAvrX89H2hNWg4w3Yqo3Eiu3mLe1nntUeiMdqMUFJhbTCJiSc2aYVw5MrmbZyYauPefV7FdoMPPQvC1yq5SYh+tnW8KlvxTzgAmmblOkjdDzZN75Oo8Elo9omWRAeMSyNS6rTJRXlipZyIRs4kdqSmutfpNjyGt+9BnF+UjsgiN9LE4g6mGGULrweheuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s75O3+FHcYT3y+0zKTWe4bcO4kUCKwS56yc8yO+18qc=;
 b=53b/FMiCEcOW9ATax9yGUq8VTZxLa1gK28sFX4J3HCYEzCp6588BwvG6DPiyTmGrWx9C+b+hhLxZrbAB7frUyEl6RFla4/yhxF/p2wIP2CnAvPegc837csZrpeS4Pdd07kkWTuvXciYxI/s0RXM/ciRyLwILC+mg+7uE4NWbT9KF9n9oUS8mbPyAjC80blHSgowHSeE3ujacm8G8+amw11350BVGHtK2/0svNDY+dtD+GqezCRtVwZL+Y0gd90EcUQzH70SYMpmNIQ3PttRf9i1eeXeIPsMQkrPmjuhPJ7uHETsu24753qWYaq6R2sVxCPsvCRIeih8LQSlUXHiF3Q==
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by CH3PR11MB8561.namprd11.prod.outlook.com (2603:10b6:610:1ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 17:15:36 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::613:fb5:737:dae8]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::613:fb5:737:dae8%7]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 17:15:36 +0000
From: <Ajay.Kathat@microchip.com>
To: <alexis.lothore@bootlin.com>, <davidm@egauge.net>
CC: <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: wilc1000: validate chip id during bus probe
Thread-Topic: [PATCH] wifi: wilc1000: validate chip id during bus probe
Thread-Index: AQHaTXfuVyXu+UQNkEOt6vVeWNVJQrDmYtaAgADNRwCAAHtPgIABAX6AgACOnACAABSIgIAAwv6AgABOiwCAAGexAA==
Date: Thu, 25 Jan 2024 17:15:36 +0000
Message-ID: <a2f6359b-878b-485c-98bd-beeb1a04292c@microchip.com>
References: <20240122211315.1444880-2-davidm@egauge.net>
 <20240122220350.1449413-1-davidm@egauge.net>
 <751bf8e4-c81c-495b-9166-9f91f9c4b2d5@bootlin.com>
 <b8e8a3f82fe240506e82322a10be7b4e9f218eca.camel@egauge.net>
 <0d77d857-35ce-43bc-aaf3-2b46c01a44ec@bootlin.com>
 <ab077dbe58b1ea5de0a3b2ca21f275a07af967d2.camel@egauge.net>
 <eb20373c68936f032c322174fbbd3353167d898a.camel@egauge.net>
 <c5118672-7e67-4601-a570-52c8e212aeda@microchip.com>
 <6fa6c238-9938-4e14-9b99-95759b659147@bootlin.com>
In-Reply-To: <6fa6c238-9938-4e14-9b99-95759b659147@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_|CH3PR11MB8561:EE_
x-ms-office365-filtering-correlation-id: 3e6bcbd7-f9db-4beb-6b4d-08dc1dc93f3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kMDVqwX2ZwfR9XW3WKF02e4pQffHk8fFPKxTL3ZyysXP8jei5hxBron7nPBHMOKQgqhy/8ufpTVnAcTh89Sh+H9NcumCd+jIDPm27HwbTIffc7iXikt5+xx8JopyVZX3DquJhiTHfW2kaBHD4N/RBNMI0pOyygCAnyOcqTkLgbgtybCZZCfaeMknlYrI5996K/F2OT0dDRa0Y7nJcM8WEQ5zy7f3vl9c7mzCBYYxn6GoxnUYTvmmluEykHi9NYCnNkZDp9JQmvLHvb/xn2/pgRfLHu8GtdByeEaOz8bNZxqrPQPD8RkT26RTEngJNQ4YCUx1p/PvWAf3Cc+ba30a9B1HuloDrwlO0jNfy3zk3doEtIow1Y1GTtsKw83ASF+r6t8Cq0u34IeHvO6hTcYgL1X8Vk54FJGk+3bCI3OLM8XFkRIXTpmbdEx8KFgUBi8wKKO12+IwLOT0GLDzYciAHh8Pk1CmhpDXBL3qV/mJ3pAQjEyZk3d+dB1PtyyYP+GSfy+h4qv5uP6gYLnzMMwlyyy1eY7YnYeR7gq6zoKZxcIRv+J+T9KyMTnEuMP9wZ+KTUsBoc4PcSFhWXwWcyaJsntaashk4A8epL3QypkwLMqIUkbn1GOwpRz+1FmuHW5EwZPsw8rOvDuDSSKwS2jCdAe7NoStK/cCnz5eTwPqwo9OxJh5P2PhISP2SU8m9A7gz0/zHKJL4rmYlwzYpVVlr0kMKRxcy+c18PXNoiEZpWk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(376002)(366004)(230173577357003)(230922051799003)(230273577357003)(1800799012)(64100799003)(451199024)(186009)(53546011)(6506007)(26005)(4326008)(83380400001)(2616005)(316002)(6512007)(41300700001)(8676002)(8936002)(36756003)(64756008)(54906003)(2906002)(5660300002)(66556008)(76116006)(66476007)(66446008)(66946007)(38070700009)(110136005)(31696002)(86362001)(71200400001)(478600001)(6486002)(31686004)(122000001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Yk5XWjFTV1BXTXMrR2xYclRpcUJmdzQyd0ZRa2IraEJqdVlKN2pIdVZrTVVU?=
 =?utf-8?B?UkdyR1FMVFhoMHVaSmJmUVFzV3NjQ201Z0ZIaE90czFPU0NXZVlCU2lCUnlp?=
 =?utf-8?B?eStxbGtNUlFUVDJwQWlCNU0rMGlkSEgyS1AyenR6aEtKdllJMzJlSlNRUTFN?=
 =?utf-8?B?c1hQTVdpZ1hjcDNxRkpuK0c2WDRTL0JkSm5POWxGc0h4a3RTS1J4UnVjWHBk?=
 =?utf-8?B?OVdIQXJTMG1wZjJMSy9KQnZGNzFqWFlJTDZOdUNrTFdVWGplZFR2eE5PQ3J5?=
 =?utf-8?B?Z0VVVFFNdFBaZWlKdFNOVWdvK1JnRUdaeFd3Y2pPcm1STWtzVkF1bEZENDhU?=
 =?utf-8?B?RGRROHkzclRlK29FK2lIT1pORUVHZDR5YzlyZmZWc0hReHhPU0JMV3hUYits?=
 =?utf-8?B?c3gwSVV5RzBDL1o3bkNQVm1EMGNDRzg2UDQyTWtQZkxPTzdBakxJMzZiYmxM?=
 =?utf-8?B?RW5ySTdlQm0rUis2Ukt2WGVsSFMrYmZQamlNMlZjd2RhaWtjbzZ5TXp1VDBM?=
 =?utf-8?B?VkVtZG04aU9yNlpUVjRzZCtLa2RPSWlnckVyeGdzRWV1dEZoWlowL3ltZ014?=
 =?utf-8?B?K1U1LzU1YTF1QTBHKzJJTE9vQ0pVWUt1RlA2L0dhQXJ5TmE4dTQ1MlhNNEFx?=
 =?utf-8?B?eE5JZlNVWTBwK1oyR3hjVkdVTThmSk1GdWRVRHJPQjBDWGc0cHNFUFYxY0o0?=
 =?utf-8?B?VlllL0M4M0k0WEJLaEtpQXJhTkF1VVgxTjZCMXRlVFlDaitUS0Y1bllUay95?=
 =?utf-8?B?QWJ5bWE4dDAyZFQ5bGF0UUhJSWdzaVlYSGxEVDFZNXlDVHFZZFR3Ry93K2JJ?=
 =?utf-8?B?bVNNNVFQMkhaMzBId1dGSmFOSDU0ZU1yQndldkV4aHMxRWRkNzQ3WldicHR3?=
 =?utf-8?B?aTZMVXA0QlQ5cmpla3gxWHNtaWZtVHg4Q2Z0c0U1cldqelRSSWlGQUx4MHNM?=
 =?utf-8?B?a2ZYKyt6NGdEUGRjcUtkdElFWFpOMExvUDcybzRHSUpWTWVOSnlZWENudTd3?=
 =?utf-8?B?WGl2YmRHN1VPS3gxallLNzRMOWZiVCtxcDJPRitER1FVU1hmdm5ia0ZDYUM2?=
 =?utf-8?B?dE5MRzR2ODJETkQybFBqb0dCQ0ljSHF6RDVYa01hTXc3L2dqRlcvK2NrbWx0?=
 =?utf-8?B?eE5ZbExlTDR2dlJ3TXdkOHJqdHBkNWNWSmU2c0xaSWZNMnVoVFkyc2Z3V1Zk?=
 =?utf-8?B?WE9DQ0lTRWR2c3NSZVBIbml0NVNiVUE2MzU4UVpyYW9PcFVpU3hXL0N2V1ZP?=
 =?utf-8?B?N2s3OTVuUVlGSDZud2JheWNZckNHUXZPZmlkUGZxQU1RWjErMGh3N0Rxa0ln?=
 =?utf-8?B?QXpSYVFvczUvRnBlQlRPenVKOVpvVjZYcTFob04reCtyN2FUWS9IK3liNElK?=
 =?utf-8?B?ZHU1U0dIODB2OC9GdjNyRCt2SzlQWVVXOXdIMkhRdTJZVzl2N1RNeHRHcjVH?=
 =?utf-8?B?QmhSek1rVTdmRS9BUHBic0hTQ2ZlZHZab3pQeTVEcnNXZC8vR216ZDV4MnB1?=
 =?utf-8?B?VU8zNEZpMzR0RkNHbGxUT0RkS2JNMWJqQ0hKV1o4UUh5L1JsY1RzRXJwNXRw?=
 =?utf-8?B?YThqeFJlcHVIVEt5a0NrM3BNelhGcnBIa3FTb3ZyQnRIRlNwN1l4OGxWVlU0?=
 =?utf-8?B?WnZqY2JZWXdlWU8rTTRJZU5rbkJXMGxZaDE5eTlPdzhxa0FHYzBMVkZwaW5Q?=
 =?utf-8?B?ZzEzZ3BDekdzTXVENmRJbmZsYVhLZmQ3OC9tUUdkMGE3RmI4VnJqM0tmdUY4?=
 =?utf-8?B?NUhmdU9NSXhBcTB3NXo2dXBRRHR5cFdwbTZXNG9ZNVNlV1BveW1veThrMjla?=
 =?utf-8?B?alJXZUYwWWw0ZTd0bUZ2SzIzL1R3VmVFM1RZYUFMdjRmcXR3YkIxODBybDJq?=
 =?utf-8?B?THhUaU55dnk1QTAzUFlmcG56V2pKbXMwV3hCQ2ZSWEdlNkhQbjZaVjY2MERp?=
 =?utf-8?B?cVlRKytpY1g2ZmM0eGJWbHk3bUs0NTY3cWR5bjVTSGt6eWpWZkc2MXlYK3Jh?=
 =?utf-8?B?MW9VR1VUREhERXl3Z3ZseHFVeWJNOHNhR0oyTkYxYXM1d3c4dllsRGVjbHAz?=
 =?utf-8?B?eldaRDhUcWg3UlJlVDEzdlRKYTZIazZzdU84WURJa3Y3N1JHVERpcFFjekpZ?=
 =?utf-8?Q?rj1opwfoBgtbc7yfEKIsuBLGt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1493AFCF0E111F46AC47938C0184D96F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e6bcbd7-f9db-4beb-6b4d-08dc1dc93f3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2024 17:15:36.6134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Eo2HYaHy4l8NkBOU6jWHdU660owDeFpZNqHLEpLBj0miAU6zj8UvJFVY00MtQY1Q/ZPl7qND0aYFwdBBNTkeuZgN1joNDb3KkLyeZimKe2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8561

T24gMS8yNS8yNCAwNDowNCwgQWxleGlzIExvdGhvcsOpIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDEvMjUvMjQgMDc6MjMsIEFqYXkuS2F0aGF0
QG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+PiBPbiAxLzI0LzI0IDExOjQ1LCBEYXZpZCBNb3NiZXJn
ZXItVGFuZyB3cm90ZToNCj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4+
Pg0KPj4+IE9uIFdlZCwgMjAyNC0wMS0yNCBhdCAxMDozMSAtMDcwMCwgRGF2aWQgTW9zYmVyZ2Vy
LVRhbmcgd3JvdGU6DQo+Pj4+IEFsZXhpcywNCj4+Pj4NCj4+Pj4gT24gV2VkLCAyMDI0LTAxLTI0
IGF0IDEwOjAxICswMTAwLCBBbGV4aXMgTG90aG9yw6kgd3JvdGU6DQo+Pj4+PiA9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0N
Cj4+Pj4+IEJVRzogS0FTQU46IHNsYWItdXNlLWFmdGVyLWZyZWUgaW4gd2lsY19uZXRkZXZfY2xl
YW51cCsweDI5NC8weDJjMA0KPj4+Pj4gUmVhZCBvZiBzaXplIDQgYXQgYWRkciBjM2M5MWNlOCBi
eSB0YXNrIHN3YXBwZXIvMQ0KPiANCj4gUmVwbHlpbmcgYSBiaXQgbGF0ZSB0byB5b3VyIGluaXRp
YWwgcXVlc3Rpb25zOg0KPiAtIEkgYW0gcnVubmluZyBhbiBBUk0zMiBwbGF0Zm9ybSAoU0FNQTVE
MjcpDQo+IC0gZm9yIHRoZSB3aWxjX25ldGRldl9jbGVhbnVwIGxpbmUsIHRoZSAweDI5NCBvZmZz
ZXQgaW5kZWVkIHBvaW50cyB0bw0KPiBsaXN0X2Zvcl9lYWNoX2VudHJ5X3JjdSh2aWYsICZ3aWxj
LT52aWZfbGlzdCwgbGlzdCkgaW4gbXkgY2FzZSwgYnV0IHlvdSBzZWVtZWQNCj4gdG8gaGF2ZSBp
ZGVudGlmaWVkIHRoaXMgYWxyZWFkeS4NCj4gDQo+Pj4+DQo+Pj4+IE9LLCBJIHRoaW5rIEkgc2Vl
IHdoYXQncyBnb2luZyBvbjogaXQncyB0aGUgbGlzdCB0cmF2ZXJzYWwuICBIZXJlIGlzIHdoYXQN
Cj4+Pj4gd2lsY19uZXRkZXZfY2xlYW51cCgpIGRvZXM6DQo+Pj4+DQo+Pj4+ICAgICAgIGxpc3Rf
Zm9yX2VhY2hfZW50cnlfcmN1KHZpZiwgJndpbGMtPnZpZl9saXN0LCBsaXN0KSB7DQo+Pj4+ICAg
ICAgICAgICAgICAgaWYgKHZpZi0+bmRldikNCj4+Pj4gICAgICAgICAgICAgICAgICAgICAgIHVu
cmVnaXN0ZXJfbmV0ZGV2KHZpZi0+bmRldik7DQo+Pj4+ICAgICAgIH0NCj4+Pj4NCj4+Pj4gVGhl
IHByb2JsZW0gaXMgdGhhdCAidmlmIiBpcyB0aGUgcHJpdmF0ZSBwYXJ0IG9mIHRoZSBuZXRkZXYs
IHNvIHdoZW4gdGhlIG5ldGRldg0KPj4+PiBpcyBmcmVlZCwgdGhlIHZpZiBzdHJ1Y3R1cmUgaXMg
bm8gbG9uZ2VyIHZhbGlkIGFuZCBsaXN0X2Zvcl9lYWNoX2VudHJ5X3JjdSgpDQo+Pj4+IGVuZHMg
dXAgZGVyZWZlcmVuY2luZyBhIGRhbmdsaW5nIHBvaW50ZXIuDQo+IA0KPiBZb3VyIGRpYWdub3N0
aWMgc291bmRzIHJlbGV2YW50IDopDQo+IA0KPj4+PiBBamF5IG9yIEFsZXhpcywgY291bGQgeW91
IHByb3Bvc2UgYSBmaXggZm9yIHRoaXMgLSB0aGlzIGlzIG5vdCBzb21ldGhpbmcgSSdtDQo+Pj4+
IGZhbWlsaWFyIHdpdGguDQo+Pj4NCj4+PiBBY3R1YWxseSwgYWZ0ZXIgc3RhcmluZyBhdCB0aGUg
Y29kZSBhIGxpdHRsZSBsb25nZXIsIGlzIHRoZXJlIGFueXRoaW5nIHdyb25nDQo+Pj4gd2l0aCBk
ZWxheWluZyB0aGUgdW5yZWdpc3Rlcl9uZXRkZXYoKSBjYWxsIHVudGlsIGFmdGVyIHRoZSB2aWYg
aGFzIGJlZW4gcmVtb3ZlZA0KPj4+IGZyb20gdGhlIHZpZi1saXN0PyAgU29tZXRoaW5nIGFsb25n
IHRoZSBsaW5lcyBvZiB0aGUgYmVsb3cuDQo+IA0KPiBJIGd1ZXNzIHlvdSBfY291bGRfIGRvIHNv
bWV0aGluZyBsaWtlIHRoaXMsIGJ1dCBJIHRoaW5rIHlvdSBoYXZlIHRvIGJlIHZlcnkNCj4gY2Fy
ZWZ1bCBhYm91dCBwb3RlbnRpYWwgcmFjZXMuIElmIEknbSBub3Qgd3JvbmcgdGhlIGZvbGxvd2lu
ZyBjb3VsZCBoYXBwZW46DQo+IC0geW91IGVudGVyIHRoZSB3aWxjX25ldGRldl9jbGVhbnVwIGFu
ZCBzdGFydCByZW1vdmluZyB2aWZzIGZyb20gbGlzdA0KPiAtIG1lYW53aGlsZSwgYmVjYXVzZSB5
b3VyIG5ldCBkZXZpY2UgaXMgc3RpbGwgcmVnaXN0ZXJlZCwgdXNlcnNwYWNlIGNhbiBzdGFydA0K
PiBjYWxsaW5nIGNvbmN1cnJlbnRseSBzb21lIGNnZjgwMjExX29wcw0KDQpJRkFJSyBjZmc4MDIx
MV9vcHMgc2hvdWxkbid0IGdldCBjYWxsZWQgdW50aWwgdGhlIG5ldGRldiBpbnRlcmZhY2UgaXMN
CnVwKGlmY29uZmlnIHdsYW4wIHVwKS4gSW4gdGhlIHByb2JlLCBvbmx5IHRoZSBuZXRkZXYgaW50
ZXJmYWNlIGlzDQphbGxvY2F0ZWQgYW5kIGNmZzgwMjExX29wcyBpcyByZWdpc3RlcmVkIGFuZCB0
aGUgY2ZnODAyMTFfb3BzIGNhbGxiYWNrDQpzaG91bGQgYmUgY2FsbGVkIHdoZW4gdGhlIGludGVy
ZmFjZSBpcyB1cC4NCg0KPiAtIHNvbWUgb2YgdGhvc2Ugb3BzIG1heSB0cnkgdG8gZ2V0IHRoZSB2
aWYgbWF0Y2hpbmcgeW91ciBuZXRkZXZpY2UgZnJvbSB0aGUNCj4gbGlzdCwgYnV0IGl0IGlzIG5v
dCB0aGVyZSBhbnltb3JlDQo+IA0KSSBoYXZlIG5vdCB0ZXN0ZWQgdGhpcyBieSBlbmFibGluZyBL
YXNhbiBjb25maWd1cmF0aW9uIHNvIEkgaGF2ZW4ndA0Kb2JzZXJ2ZSB0aGlzIGlzc3VlIHlldC4g
QXMgSSB1bmRlcnN0YW5kLCB0aGUgd2FybmluZyh1c2UtYWZ0ZXItZnJlZSkgaXMNCnJlcG9ydGVk
IGZvciB0aGUgYmVsb3cgbGluZSBpbiB3aWxjX25ldGRldl9jbGVhbnVwKCkgc28gdGhhdCBtdXN0
IGJlIHRoZQ0KY29kZSB3aGVyZSB1c2VkLWFmdGVyLWZyZWUgd2FybmluZyBpcyByZXBvcnRlZC4g
SXNuJ3QgaXQuDQoNCj4+Pj4gICAgICAgbGlzdF9mb3JfZWFjaF9lbnRyeV9yY3UodmlmLCAmd2ls
Yy0+dmlmX2xpc3QsIGxpc3QpIHsNCg0KDQo+IE1heWJlIHNvbWUgcnRubCBvciB3aXBoeSBsb2Nr
ICh1c2VkIGZyb20gY2ZnODAyMTEgY29yZSBvciBuZXQgY29yZSkgd2lsbCBzYXZlDQo+IHlvdSBm
cm9tIHRoaXMgZm9yIHNvbWUgb2Ygd2lsY19uZXRkZXZfY2xlYW51cCBjYWxscywgYnV0IEkgdGhp
bmsgdGhhdCB3b24ndCBiZQ0KPiB0cnVlIGZvciB0aGUgb25lIGluIHRoZSBlcnJvciBwYXRoIG9m
IHRoZSBwcm9iZSBjaGFpbi4NCj4gDQo+PiBJIHRoaW5rIHdlIG5lZWQgdG8gaW52ZXN0aWdhdGUg
dGhlIGFjdHVhbCByZWFzb24gZm9yIEthc2FuIHdhcm5pbmcuDQo+PiBGaXJzdCwgd2UgbmVlZCB0
byBjb25maXJtIGlmIHRoaXMgd2FybmluZyBleGlzdHMgd2l0aG91dCB0aGUgcGF0Y2godGVzdA0K
Pj4gYnkgc2ltdWxhdGluZyBhIGZvcmNlIGVycm9yIGluIHdpbGNfYnVzX3Byb2JlKCkpLiBXaGVu
DQo+PiB3aWxjX25ldGRldl9jbGVhbnVwKCkgaXMgYWxzbyBjYWxsZWQgZnJvbSB3aWxjX2J1c19y
ZW1vdmUoKSwgSSBiZWxpZXZlDQo+PiB0aGlzIHdhcm5pbmcgd2FzIG5vdCBvYnNlcnZlZC4gT25j
ZSBpdCBpcyBjb25maXJtZWQsIHRoZSBmaXggY2FuIGJlIGRvbmUNCj4+IGFjY29yZGluZ2x5Lg0K
PiANCj4gSXQgaGFwcGVucyB0b28gaW4gd2lsY19idXNfcmVtb3ZlOg0KPiBlY2hvICJzcGkwLjEi
ID4gL3N5cy9idXMvc3BpL2RyaXZlcnMvd2lsYzEwMDBfc3BpL3VuYmluZA0KDQpPa2F5LCBzbyBp
dCBjb25maXJtcyB0aGF0IHRoaXMgd2FybmluZyBpcyBub3QgcmVsYXRlZCB0byB0aGUgcHJvYmUN
CmZ1bmN0aW9uLg0KDQo+IA0KPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gQlVHOiBLQVNBTjogc2xhYi11c2UtYWZ0
ZXItZnJlZSBpbiB3aWxjX25ldGRldl9jbGVhbnVwKzB4ZjAvMHgyNDQNCj4gUmVhZCBvZiBzaXpl
IDQgYXQgYWRkciBjM2M5MWNlOCBieSB0YXNrIHNoLzkxDQo+IA0KPiBDUFU6IDAgUElEOiA5MSBD
b21tOiBzaCBOb3QgdGFpbnRlZCA2LjcuMC13dCsgIzg0NQ0KPiBIYXJkd2FyZSBuYW1lOiBBdG1l
bCBTQU1BNQ0KPiAgdW53aW5kX2JhY2t0cmFjZSBmcm9tIHNob3dfc3RhY2srMHgxOC8weDFjDQo+
ICBzaG93X3N0YWNrIGZyb20gZHVtcF9zdGFja19sdmwrMHgzNC8weDQ4DQo+ICBkdW1wX3N0YWNr
X2x2bCBmcm9tIHByaW50X3JlcG9ydCsweDE1NC8weDUwMA0KPiAgcHJpbnRfcmVwb3J0IGZyb20g
a2FzYW5fcmVwb3J0KzB4ZDgvMHgxMDANCj4gIGthc2FuX3JlcG9ydCBmcm9tIHdpbGNfbmV0ZGV2
X2NsZWFudXArMHhmMC8weDI0NA0KPiAgd2lsY19uZXRkZXZfY2xlYW51cCBmcm9tIHdpbGNfYnVz
X3JlbW92ZSsweDUwLzB4NWMNCj4gIHdpbGNfYnVzX3JlbW92ZSBmcm9tIHNwaV9yZW1vdmUrMHg0
MC8weDUwDQo+ICBzcGlfcmVtb3ZlIGZyb20gZGV2aWNlX3JlbGVhc2VfZHJpdmVyX2ludGVybmFs
KzB4MjFjLzB4MmFjDQo+ICBkZXZpY2VfcmVsZWFzZV9kcml2ZXJfaW50ZXJuYWwgZnJvbSB1bmJp
bmRfc3RvcmUrMHg3MC8weGFjDQo+ICB1bmJpbmRfc3RvcmUgZnJvbSBrZXJuZnNfZm9wX3dyaXRl
X2l0ZXIrMHgxYTAvMHgyODQNCj4gIGtlcm5mc19mb3Bfd3JpdGVfaXRlciBmcm9tIHZmc193cml0
ZSsweDM4Yy8weDZmNA0KPiAgdmZzX3dyaXRlIGZyb20ga3N5c193cml0ZSsweGQ4LzB4MTc4DQo+
ICBrc3lzX3dyaXRlIGZyb20gcmV0X2Zhc3Rfc3lzY2FsbCsweDAvMHgxYw0KPiBFeGNlcHRpb24g
c3RhY2soMHhjNTg4ZmZhOCB0byAweGM1ODhmZmYwKQ0KPiBmZmEwOiAgICAgICAgICAgICAgICAg
ICAwMDAwMDAwNyAwMDRlZmY2OCAwMDAwMDAwMSAwMDRlZmY2OCAwMDAwMDAwNyAwMDAwMDAwMQ0K
PiBmZmMwOiAwMDAwMDAwNyAwMDRlZmY2OCAwMDAwMDAwMSAwMDAwMDAwNCAwMDAwMDAwNyBiNjk1
NDZjMCAwMDAwMDAyMCAwMDRlZDE5MA0KPiBmZmUwOiAwMDAwMDAwNCBiNjk1NDY3OCBhZWMzYTA0
MSBhZWJkMWEyNg0KPiANCj4+IEF2b2lkaW5nIG5ldGRldiBpbml0aWFsaXphdGlvbiBpbiB3aWxj
X2NmZzgwMjExX2luaXQoKSB3b3VsZCByZXF1aXJlIGxvdA0KPj4gb2YgbW9kaWZpY2F0aW9uIGFu
ZCBjaGFuZ2VzIGluIEFQSSBjYWxsIG9yZGVyLiBJTU8gdGhlIEthc2FuIHdhcm5pbmcgZml4DQo+
PiBzaG91bGQgYmUgaW5kZXBlbmRlbnQgb2YgbmV0ZGV2IGluaXRpYWxpemF0aW9uIG9yZGVyIGFu
ZCBpdCBzaG91bGQNCj4+IGZyZWUtdXAgdGhlIHJlc291cmNlcyBmb3IgYWxsIGNhc2VzLiBTdXBw
b3NlIGlmIHRoZSBjYXJkIGlzIG5vdCBwcmVzZW50LA0KPj4gdGhlIHByb2JlIEFQSSBzaG91bGQg
Y2xlYW4tdXAgYW5kIGV4aXQgZ3JhY2VmdWxseS4gRm9yIGRldGVjdGluZyB0aGUNCj4+IGNoaXBf
aWQsIEkgaGF2ZSBjcmVhdGVkIHRoZSBiZWxvdyBwYXRjaCBjb25zaWRlcmluZyB0aGUgYWJvdmUg
c2NlbmFyaW9zLA0KPj4gcGxlYXNlIGNoZWNrIGlmIGl0IG1ha2VzIHNlbnNlLg0KPiANCj4gQWdy
ZWUgYWJvdXQgdGhlIHdpbGNfbmV0ZGV2X2NsZWFudXAgZml4IGJlaW5nIGEgc2VwYXJhdGVkIHRv
cGljLCB0byBiZSBoYW5kbGVkDQo+IGFjY29yZGluZ2x5Lg0KPiBTdGlsbCwgdGhlIHNjZW5hcmlv
IEkgbWVudGlvbiBhYm92ZSwgaWYgdHJ1ZSwgbWFrZXMgbWUgbW9yZSBjb25maWRlbnQgdGhhdCB3
ZQ0KPiBzaG91bGQgbm90IHJlZ2lzdGVyIGF0IGFsbCB0aGUgbmV0ZGV2aWNlIGJlZm9yZSBiZWlu
ZyBhYmxlIHRvIG1hbmFnZSBpdC4gTWF5YmUNCj4gdGhvc2UgY2FzZXMgYXJlIGFscmVhZHkgaGFu
ZGxlZCBjb3JyZWN0bHkgd2l0aCBzb21lIGNoZWNrcyB0byBtYWtlIHN1cmUgbm8gcmVhbA0KPiBj
cmFzaCBvY2N1cnMsIGJ1dCBhbGwgdGhvc2UgY2hlY2tzIGNvdWxkIGJlIGF2b2lkZWQgaWYgd2Ug
ZGlkIG5vdCByZWdpc3RlciB0aGUNCj4gbmV0ZGV2aWNlIHNvIGVhcmx5DQo+IG5lZXJpbmcNCg0K
SSB0aGluayB0aGlzIGlzc3VlIGlzIG5vdCByZWxhdGVkIHRvIGVhcmx5IHJlZ2lzdHJhdGlvbiBv
ZiBuZXRkZXZpY2UNCnNpbmNlIHNhbWUgYmVoYXZpb3Igd2FzIG9ic2VydmVkIHdpdGggImVjaG8g
InNwaTAuMSIgPg0KL3N5cy9idXMvc3BpL2RyaXZlcnMvd2lsYzEwMDBfc3BpL3VuYmluZCIgY29t
bWFuZC4NCg0KSWYgbmVlZGVkLCB0aGUgbmV0ZGV2aWNlIGFsbG9jYXRpb24gY2FuIGJlIGRlbGF5
ZWQgdW50aWwgb3RoZXINCmNvbmRpdGlvbnMocmVzb3VyY2VzKSBhcmUgYWxsb2NhdGVkL3N1Y2Nl
c3NmdWwuIEJ1dCBpdCBpcyBhbHNvIHBvc3NpYmxlDQp0aGF0IHRoZSBvdGhlciBjb25kaXRpb25z
KHJlc291cmNlKSBhcmUgc3VjY2Vzc2Z1bCBidXQgbmV0ZGV2aWNlDQphbGxvY2F0aW9uIGdldHMg
ZmFpbGVkLCBpbiB0aGF0IGNhc2UgYWxsb2NhdGluZyBvdGhlciByZXNvdXJjZXMgYmVmb3JlDQpt
YXkgbm90IGJlIGNvcnJlY3QuIEZvciB0aGUgc3VjY2VzcyBjYXNlLCBhbGwgdGhlIGNvbmRpdGlv
biBzaG91bGQgc3VjY2VlZC4NCkN1cnJlbnRseSB0aGUgZHJpdmVyIGluaXRpYWxpemF0aW9uIGhh
cyBhIG9yZGVyIHRoYXQgYWxyZWFkeSBpbnZva2VzDQoibmV0ZGV2X2NsZWFuOiIgaW4gd2lsY19i
dXNfcHJvYmUoKSBmb3IgZmFpbHVyZSBjYXNlcywgc28gaXQgc2hvdWxkIGZyZWUNCnVwIHRoZSBy
ZXNvdXJjZXMgY29tcGxldGVseS4gQWRkaXRpb25hbGx5LCB0aGlzIHdhcm5pbmcgd2FzIHJlcG9y
dGVkIGF0DQpydW4gdGltZShub3Qgb25seSBpbiBwcm9iZSkuIEkgYmVsaWV2ZSBpZiBpdCBpcyBm
aXggaW4NCndpbGNfbmV0ZGV2X2NsZWFudXAoKSB0aGVuIGl0IHdpbGwgY292ZXIgZm9yIGFsbCB0
aGUgc2NlbmFyaW9zLg0KDQpSZWdhcmRzLA0KQWpheQ0K

