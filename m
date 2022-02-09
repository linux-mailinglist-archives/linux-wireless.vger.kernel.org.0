Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8864AF435
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Feb 2022 15:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbiBIOh0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Feb 2022 09:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235094AbiBIOhZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Feb 2022 09:37:25 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC4BC0613C9
        for <linux-wireless@vger.kernel.org>; Wed,  9 Feb 2022 06:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644417446; x=1675953446;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9ZU+40omtZzV/E8mYpv9GXS9YnXw+ryPUgBziN+a0ag=;
  b=tE5bmrAozXY7Vwlbdp1FWUzG5eL8I3dpWSm1afnFoRI5eESAHxCYvt56
   3w3vxSRLhOcTZ21YKVzQw8gyGaYS54kDBBS6FodOEvTr7LJ66BBjv6+wJ
   zIZrsAbPsq8d7qRZHXzn7+PUx3bfZmQn1KagNR9VuKEVwNvQ+YM3V8JvA
   2ua/F6cHTyW9x6YyR9UWnePmTr+9Q6f37+KkKK9LfILMVwAwuRRJIeEyE
   7lN6KBkvBgj7ryIidy/S3/a4MU7mCEgymi5hG3kG1qIUuMDWT2Qafh0+0
   BWqp5/LgzzPTjPfgnT2vm7USL5ECrw6bRJE5WdD1Gfi6k4WLL34CfiXOm
   g==;
IronPort-SDR: a1Ol/Liu89sADrRu2Y4vKPNC2xrdHlJlMb7N7Rsj7uagYRmPQUQLDd7TJDG0G87tCCWvYxF34c
 e/zzlwrVpru0R2ehgspTj/GjZGeEEN5Y5sEJqKnj6v7dG3cQ9cH/MCKg6NO2+KF5SWf0iUA2Li
 mAd2wqNZwpHjfpbEu3fTSwcmCBePXuW80qEGPIz8k2zssu1I6ueJtpS/izGHqdj/M4Sf41dBHt
 1+Ye355mSFVfs6EapUfLP90EP/Z3rRxmEP8UktQnw3yyQdjtXPPMPvMYBaPMcbwEDzEy5HB0ht
 rPhhbzSJ7uoXfOZ64Wjy7qYj
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="148138130"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Feb 2022 07:37:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Feb 2022 07:37:24 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 9 Feb 2022 07:37:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4Weqxf/uyWSEZvSNWoX0L9qvW9zrccUrOdjwE38TbW4EI6U/9xd+/zT6xLdDOlTogavsHCfypnd4WE04OfpSQVG/tq7P7v+eP/bhmdX39TdRLdKPYcvKWsx1G+s7f/1pU7AEs2Bdwzj/mFkwG7q/svodNAFE+hI9lF1AGaGmZop7OXs5oHQXYQuYw96ClUTUjGEqwX9F27kB0UtxG3SMTY76Hb9pb/nSjecsgHHGKuWgpKz030BEJIRw+38Dv84q161P9Iya25ty68neiGHeWO+f1vjBFLQ8WC+ARBYuISGLYTcXRGox/fJmgDj3Cqa/MtZtW/b1HUvGQ9lC+hF3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZU+40omtZzV/E8mYpv9GXS9YnXw+ryPUgBziN+a0ag=;
 b=f9+aiJiMoYoED/C5sRjPU3IN2XbrsRu9NWo7dVt3f+WdzvAX/MgvKbEZABm/M58K3HvMdQkxwRij5nI8kXxTu+xAWZYMPbFfLSKnvR9w989Va/tXURA+7rknYTo0x4arxpYW1wElxG0gvVgwUNnkFQB4jR4kXxyrH6S5gDxWfOAuS6tWjC9Gc1wSluRAKjOXpKPfiqDpBgh81DtIDhFmq3RhFpxbQUqhcq9/kk1zKFzTxEj15n3CchzV1TUFDQZDT3vTmFnl9AOULzvf12GV9wKD1W5pem4/q+LPIDtCA8eHKcMRg1tE4Kbd6lbPi+0QHGq69hNbDtPCyRw3atDQ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZU+40omtZzV/E8mYpv9GXS9YnXw+ryPUgBziN+a0ag=;
 b=qDKoTnNGCsinnyojTohlnslAjNkX9GRxjhk48EWsT5sjDib0eYwscv5iw+tRr+qRWPu0QvNxrIsY16r77pGz2ibVYPiA5AVUm0WYPRvuaVirh2GowY50X6HsnPRqjsW3cQBCua3N61TGtQn4x+3/c1JLRD0he5nhvAaQ+qiRfiE=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by DM5PR1101MB2204.namprd11.prod.outlook.com (2603:10b6:4:58::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 14:37:23 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::bdea:48bb:2b17:e59d]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::bdea:48bb:2b17:e59d%6]) with mapi id 15.20.4951.018; Wed, 9 Feb 2022
 14:37:23 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <cniedermaier@dh-electronics.com>, <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Tudor.Ambarus@microchip.com>,
        <ageisreiter@dh-electronics.com>, <marex@denx.de>
Subject: Re: Possible bug on wilc1000 [Klartext]
Thread-Topic: Possible bug on wilc1000 [Klartext]
Thread-Index: AdgdBYpowDRGmRhhS4ylc9cEzwODUwAvQHEA
Date:   Wed, 9 Feb 2022 14:37:23 +0000
Message-ID: <97d9da81-f15b-33dd-a66e-9f6dbe2c3b0c@microchip.com>
References: <3994a34bb0d84e9d8181ec490a3f71d2@dh-electronics.com>
In-Reply-To: <3994a34bb0d84e9d8181ec490a3f71d2@dh-electronics.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 787fe747-8ab8-4b9c-711c-08d9ebd9af77
x-ms-traffictypediagnostic: DM5PR1101MB2204:EE_
x-microsoft-antispam-prvs: <DM5PR1101MB220429DCD543E50D828A1507E32E9@DM5PR1101MB2204.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FMeIMK660/07n4tXWETV8K9UwjHxjzS3vmTRIkP1IUCbA+2VZppggU+zN5eZ25soFzR08BM/NTRpjbmrRi88k0dcTM5lWs/N+gyNtuLPN+WW7KC6wZsPjlmYFo7DcsVaW6xqbks+jBOXkbUhrid/fiX6sXQJ3soHpAElZBodK3nWrlvZO4UPxK081JDZW2P9ObHP6Ls4oPhwLRAwSlnepdinhCDgmEvg6jeg1kgDZRXtohGPGW35IYT4N5QyTTgB3DSGJJcqYopfbGSM7Oxem4n64+jB1Wob9MNPMIDcEjUEqFTU7m/ZM6GaCybIu/7q8wrcDT1UWq7lF/XB4MUsk0TjsXl2Umc4fwfGvLWRppMz6kO7/z21toVGkN4IR6CzSEWuFRXikpl4IBtGnm1U7+epOga/Cr6Y9MckivmykZPNVQK1oXBLegrnZI50xQsG6fE+fjFFNQu5v60IQ1N05+s44vX2GT3zBuvdX4lXm3ZRsuHzvhIeJ7yGrg0FteIIcjULNKXhzD2jRhzp8qlyGlPR8YJmZum1g/CVkg1VIGIsiqjp7atM9UtT5EPXzzNAe2t3ZoXYVtUfHdeVE0fRwz/84YPuFxuplDYdjvRWsxeQFtoujLmZf2+c6pjhy8vjmNw1702AHgCOGtG3Lkm7/klGlHOCGga8SNa1+bNp8ujG3G6vONlGRJ2Ab6vxIy8EeeZxGOkaXlsZpvMwO2NawmidyXj0gfno8DI8rD4Vnfi9kQjmSZQLARYWm4aLGiY066O1xBHMlEzazr5Bi1OasQF9o8YSB+M4CYSYC5E7pOVbesoGPEbbNYCQBh3ARCymCis+pfPol43MDOmRQRz6FSvhFCF+BWiqlEYVw+y5FRo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(110136005)(4326008)(53546011)(508600001)(6506007)(66946007)(76116006)(66476007)(66556008)(64756008)(66446008)(8936002)(8676002)(6486002)(38100700002)(55236004)(86362001)(91956017)(71200400001)(38070700005)(31686004)(2616005)(186003)(83380400001)(6512007)(316002)(54906003)(26005)(5660300002)(2906002)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFdxNmRuN3Y0Y0RhRW5aWUJRYWhrSnpiMHZKRW5HQmNTSkZVd1FGc29tU3Mv?=
 =?utf-8?B?TE5lNEV1Y1BBSDZnRVNZVjhZcmJncDNPSXpRTWtvT2hKazFWY1dCR3RVZGZW?=
 =?utf-8?B?QXJrSDIzem85RlcralJmZWRxdFRmOTd4YzV5NEhqSXBFOUZPYlFGRW54QmJw?=
 =?utf-8?B?MThhZ2NrenBvZHcwbG9xTFZUWGUxVFJOSjkxYUQyZk5MMmlpdWZBS3A4QWFj?=
 =?utf-8?B?MllTcDM4NDByTkYvNy9QMmlkOTFlYjFWMGRwSit4d3JsNGRnZVI4ajZWbjhT?=
 =?utf-8?B?aGE2ZmxkZFhCSXNsUC84QjM4cS9CQXNad1Y5QXAvQTBGNWdOMFh1N2xCR3hS?=
 =?utf-8?B?ejFhNU1lSVJ1amVXQVFraU8zY0NSUGVvNHVPSXNCdU9FVXBRTDZGVnhycG90?=
 =?utf-8?B?M3FHUXlLNXFEWjVmRk1xMzdnUXhXOFo4citDSlZRVkJOaUZpeFltZzFvYWc0?=
 =?utf-8?B?NlN1MmhLZHFFTnlZRnJIdUQ5aEErbWpydE1kZ05IaHpKZ1JHT1FLcWE5SkYx?=
 =?utf-8?B?eG5uNStGRUhGb0VXcTYwL2xrOGdSSFZiUFlUbTRDcWVWMjByR1F2VDZHeUhO?=
 =?utf-8?B?TG4wRWIwZDRBcjJ4Z2NxWUlFVUF4bjF1bGhRVVJHa1NXbG5sRmYvd1JxcHo0?=
 =?utf-8?B?Y1FUMkhRa1duTGxMK2k5MmtFR0g4NWNWNnBGQWQ0cGJaNU9SRlEvYVVwUFZX?=
 =?utf-8?B?NWwyQUtGY2FhSGNkNC9xMklwWGIyQWxuU1FQRGtNKzI5Qi9vMkRQRUV6aGJQ?=
 =?utf-8?B?MDcyZlRvQzE2UWtLamdGTW1FQzNEQ2FvcGJYdFY2QzFjZkQ4Rm81VmdtYXhj?=
 =?utf-8?B?cFVxYnZVcEpTYlFUOFFyUm81S3B3UDBFSHNYYmNIMCtvZWp6RitxenRVNjU2?=
 =?utf-8?B?NFlmeGo3d3NsVHZVZjI3OFVVWHFPQkwwV2dscHZsajJWdThlZkFSWk9ZYjFH?=
 =?utf-8?B?M0ZDT0ZWT29DdUc0QW5KM3lsSHhVdUlXNmRTdHJERGxzMHVNWC9taW9Wb2JF?=
 =?utf-8?B?VGpCRDZKaElkcERuejF3RmRTb0o2VVdqV0t2Q1RzR3hnWlNDK1Y0UEZtUlJv?=
 =?utf-8?B?dlA5b3YzVHMxQWwxSUFuR3VOb2hTSFN5TWllbFNPYk9Zc3VCZjBoNStWYUxL?=
 =?utf-8?B?ZjdMMHBHQ2RHSGQrZDh1MUlKeFBSalBoUHMyRk5MOXlmZ1lFbmVsZE1FVXRu?=
 =?utf-8?B?d014UnJSOFhrSzZDWmgwTzJUSjE3eXNyU2lOdHM5ZHZWcEJ1UzhlSi9SMVFP?=
 =?utf-8?B?MEN0UFlNMTdLNGgvY2hhNllMaWkwWnc4WjNiN2ZMMXk4aWxZSURRTmxNSFI0?=
 =?utf-8?B?QlFqc1NjTDFiMXphWFFFRHUrdHA4bm9oaW9rQmdCTVFvWVZwVEdDOEtsaytD?=
 =?utf-8?B?UW9uZGw4cjBTVzFNSGVjeDFTN0xtSTlhOXFTdzBwR3BZbjZKdjc1dEVVekl3?=
 =?utf-8?B?R3YwWFlwSHZjK0hBUXlzYkNZQmRJQnUxZE9pSXVrWlM1TnZNdjBYM3RRTk5L?=
 =?utf-8?B?aGM4VEVLSzEzaERSNkl0UzdGenVsaGlxQmxSbFpmdndRbkpqNVlqYnd6OVdj?=
 =?utf-8?B?emJkNXVTTGJudFlicm9lQ3FoRGhuVDdWSVUxVHdnUHhGazA1N0FXSjJiQXNR?=
 =?utf-8?B?enhRNUdyMElTa25ZY0lEMUo3MU9lNjZIdE1NaDJFZFh5OUd0U1ZTNmlNYWMw?=
 =?utf-8?B?RFByaXRqT1hobWRmZ0JBSXhqWjBtQWpNc2pHNFZ1SWxRT0hXM0VzZnBiQk1x?=
 =?utf-8?B?bWp4QUl0Ukk1L2lhWURBTDdoWk5MRmNhc1lMSlprMnhQcWkxR2N1c015NWNF?=
 =?utf-8?B?N0pnRlQ5ZlB6dGNMZC8wejNpUFRTVTVFaVpPMjM5VFZzZTJWT1d6YTIzUkx2?=
 =?utf-8?B?b3Fmc1BGK0d0N1pMQUQyVENsOXZRTEZhdXR4SlJaK2lRZ0k0SWFSWXI5cDBY?=
 =?utf-8?B?U2tzUXcrTHI3VWFlTkczM3RHWkxPQTc3elRobm52K3QyNnRQc0dQWDlZQms0?=
 =?utf-8?B?YVRmWTZFaElkeVFsMVlKVTRBT2tiSzYyb0F6ZlNIUDRseXExbVBuOEhvbVNa?=
 =?utf-8?B?K1J6VGY5UlcwWUkwVjF6ay80Wlc1V0FscWhrbGdqUVBuaE5rcGlOT2hCMzdm?=
 =?utf-8?B?THQ3WExIZVdnNkxVQkVIdThtWXp5SzByOTJEU1VQTHEyTFFiQm9jN0ptTDE5?=
 =?utf-8?B?a1RiZ3RCVUVnRG5hRlRxVWdrSGdlaFJSNVcwNXBtak9tRTA2aEZLc05nb2tF?=
 =?utf-8?B?ZDZLTDR6dVdwSG92blQzU3Z6ME1RPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A85326E787D79547B25C8951C2D73BC1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 787fe747-8ab8-4b9c-711c-08d9ebd9af77
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2022 14:37:23.2800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +9wm1yCCqtDw2bAQVC0FReTdhEekZemSqLF0okSrJJI2ZKl3yr4qtMIDQU4xghfT0dm2qr9L96+4T2vuyYJEmRdqZkcbCp3hzWBpm4GJIAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2204
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gMDgvMDIvMjIgMjE6NTYsIENocmlzdG9waCBOaWVkZXJtYWllciB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+DQo+IEhlbGxvLA0KPg0KPiBJIHRlc3RlZCB0
aGUgd2lyZWxlc3MgY2hpcCB3aWxjMTAwMCB3aXRoIHRoZSA1LjE2LjUgS2VybmVsIGFuZCB0aGUg
ZmlybXdhcmUgdjE1LjQuMQ0KPiAoaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4
L2tlcm5lbC9naXQvZmlybXdhcmUvbGludXgtZmlybXdhcmUuZ2l0L3RyZWUvYXRtZWwvd2lsYzEw
MDBfd2lmaV9maXJtd2FyZS0xLmJpbikNCj4gb24gYW4gaS5NWDYgUVVBRCB3aXRoIGlwZXJmMzoN
Cj4NCj4gIyBpcGVyZjMgLWMgSVBfQUREUiAtUCAxNiAtdCAwDQo+DQo+IEFmdGVyIGEgd2hpbGUg
dGhlIHRlc3QgZ2V0cyBzdHVjayBhbmQgSSBnb3QgdGhlIGZvbGxvd2luZyBrZXJuZWwgbWVzc2Fn
ZXM6DQo+IG1tYzA6IFRpbWVvdXQgd2FpdGluZyBmb3IgaGFyZHdhcmUgaW50ZXJydXB0Lg0KPiBt
bWMwOiBzZGhjaTogPT09PT09PT09PT09IFNESENJIFJFR0lTVEVSIERVTVAgPT09PT09PT09PT0N
Cj4gbW1jMDogc2RoY2k6IFN5cyBhZGRyOiAgMHgxMzhmMDIwMCB8IFZlcnNpb246ICAweDAwMDAw
MDAyDQo+IG1tYzA6IHNkaGNpOiBCbGsgc2l6ZTogIDB4MDAwMDAxNTggfCBCbGsgY250OiAgMHgw
MDAwMDAwMQ0KPiBtbWMwOiBzZGhjaTogQXJndW1lbnQ6ICAweDE0MDAwMTU4IHwgVHJuIG1vZGU6
IDB4MDAwMDAwMTMNCj4gbW1jMDogc2RoY2k6IFByZXNlbnQ6ICAgMHgwMWQ4OGEwYSB8IEhvc3Qg
Y3RsOiAweDAwMDAwMDEzDQo+IG1tYzA6IHNkaGNpOiBQb3dlcjogICAgIDB4MDAwMDAwMDIgfCBC
bGsgZ2FwOiAgMHgwMDAwMDA4MA0KPiBtbWMwOiBzZGhjaTogV2FrZS11cDogICAweDAwMDAwMDA4
IHwgQ2xvY2s6ICAgIDB4MDAwMDAwOWYNCj4gbW1jMDogc2RoY2k6IFRpbWVvdXQ6ICAgMHgwMDAw
MDA4ZiB8IEludCBzdGF0OiAweDAwMDAwMDAwDQo+IG1tYzA6IHNkaGNpOiBJbnQgZW5hYjogIDB4
MTA3ZjEwMGIgfCBTaWcgZW5hYjogMHgxMDdmMTAwYg0KPiBtbWMwOiBzZGhjaTogQUNtZCBzdGF0
OiAweDAwMDAwMDAwIHwgU2xvdCBpbnQ6IDB4MDAwMDAwMDMNCj4gbW1jMDogc2RoY2k6IENhcHM6
ICAgICAgMHgwN2ViMDAwMCB8IENhcHNfMTogICAweDAwMDBhMDAwDQo+IG1tYzA6IHNkaGNpOiBD
bWQ6ICAgICAgIDB4MDAwMDM1M2EgfCBNYXggY3VycjogMHgwMGZmZmZmZg0KPiBtbWMwOiBzZGhj
aTogUmVzcFswXTogICAweDAwMDAxMDAwIHwgUmVzcFsxXTogIDB4MDAwMDAwMDANCj4gbW1jMDog
c2RoY2k6IFJlc3BbMl06ICAgMHgwMDAwMDAwMCB8IFJlc3BbM106ICAweDAwMDAwMDAwDQo+IG1t
YzA6IHNkaGNpOiBIb3N0IGN0bDI6IDB4MDAwMDAwMDANCj4gbW1jMDogc2RoY2k6IEFETUEgRXJy
OiAgMHgwMDAwMDAwNyB8IEFETUEgUHRyOiAweDRjMDQxMjAwDQo+IG1tYzA6IHNkaGNpLWVzZGhj
LWlteDogPT09PT09PT09IEVTREhDIElNWCBERUJVRyBTVEFUVVMgRFVNUCA9PT09PT09PT0NCj4g
bW1jMDogc2RoY2ktZXNkaGMtaW14OiBjbWQgZGVidWcgc3RhdHVzOiAgMHgyMTAwDQo+IG1tYzA6
IHNkaGNpLWVzZGhjLWlteDogZGF0YSBkZWJ1ZyBzdGF0dXM6ICAweDIyMDANCj4gbW1jMDogc2Ro
Y2ktZXNkaGMtaW14OiB0cmFucyBkZWJ1ZyBzdGF0dXM6ICAweDIzMDANCj4gbW1jMDogc2RoY2kt
ZXNkaGMtaW14OiBkbWEgZGVidWcgc3RhdHVzOiAgMHgyNDAyDQo+IG1tYzA6IHNkaGNpLWVzZGhj
LWlteDogYWRtYSBkZWJ1ZyBzdGF0dXM6ICAweDI1YjQNCj4gbW1jMDogc2RoY2ktZXNkaGMtaW14
OiBmaWZvIGRlYnVnIHN0YXR1czogIDB4MjYxMA0KPiBtbWMwOiBzZGhjaS1lc2RoYy1pbXg6IGFz
eW5jIGZpZm8gZGVidWcgc3RhdHVzOiAgMHgyNzUxDQo+IG1tYzA6IHNkaGNpOiA9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiB3aWxjMTAwMF9zZGlvIG1tYzA6
MDAwMToxOiB3aWxjX3NkaW9fY21kNTMuLmZhaWxlZCwgZXJyKC0xMTApDQo+IHdpbGMxMDAwX3Nk
aW8gbW1jMDowMDAxOjE6IEZhaWxlZCBjbWQ1MyBbMF0sIGJ5dGVzIHJlYWQuLi4NCj4NCj4gSSB0
cmllZCB0byByZWR1Y2UgdGhlIGNsb2NrIHNwZWVkIHRvIDIwTUh6IGluIHRoZSBkZXZpY2V0cmVl
IHdpdGgNCj4gbWF4LWZyZXF1ZW5jeSA9IDwyMDAwMDAwMD47DQo+IGJ1dCB0aGUgcHJvYmxlbSB0
aGVuIGFsc28gb2NjdXJzLg0KPg0KPiBJcyB0aGlzIGEgcG9zc2libGUgYnVnPw0KPg0KPg0KDQpU
aGUgYnVzIGVycm9yIHNlZW1zIHRvIGJlIHNwZWNpZmljIHRvIHRoZSBob3N0IGR1cmluZyB0aGUg
U0RJTyB0cmFuc2Zlci4NCkhvdyBsb25nIGRvZXMgaXQgdGFrZSB0byByZXByb2R1Y2UgaXQ/IERv
ZXMgdGhlIGlzc3VlIGFsc28gaGFwcGVuIA0Kd2l0aG91dCAiLVAgMTYiIGlQZXJmMyBvcHRpb24/
DQoNCkl0IG1pZ2h0IGJlIHdvcnRoIHRyeWluZyB3aXRoIHBvd2VyLXNhdmUgbW9kZSBkaXNhYmxl
ZC4gVGhlIFBTIG1vZGUgY2FuIA0KYmUgZGlzYWJsZWQgZWl0aGVyIGJ5IHNldHRpbmcgV0lEX1BP
V0VSX01BTkFHRU1FTlQgV0lEIHRvIA0KMChXSUxDX0ZXX05PX1BPV0VSU0FWRSkgaW4gIndpbGNf
c2V0X3Bvd2VyX21nbXQoKSIgb3IgY29tcGlsZSB0aGUga2VybmVsIA0Kd2l0aCBDRkc4MDIxMV9E
RUZBVUxUX1BTIGRpc2FibGVkLg0KDQpSZWdhcmRzLA0KQWpheQ0KDQo=
