Return-Path: <linux-wireless+bounces-2332-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B82C836DE2
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 18:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2929628C00F
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 17:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4B446539;
	Mon, 22 Jan 2024 16:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="WkBEhsIN";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TS5HrYmK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB833D573
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jan 2024 16:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705942650; cv=fail; b=WHa2jDPjxb9l3HQ8akFAd0otmIAwq5Egiy4DcJglID7bHn10brnyq6fLpJwx9yyPsviWN2lqtE2njgUHd2NqwDEw0/2RIOjqrXvQk3blm/2SBsbGfbk6AdICAugSbx8PeBFIfFuvd1alVCxPt0ZBfMPfKiG+t8nMtsB05GkwrTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705942650; c=relaxed/simple;
	bh=Bo0hrWdSRgHFLDSSP0QchiILdpicQToJNCUhwG++r6Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=faXzTnee3bVittM5M6ixWZrYWA+N0settJu+0plR44Ebfsy5/hzW7DM7OsFiBtIMAyFOosIkGpZCRjkUKcx3s9pNWDFDTcX4Vw5nJsqBa68IA3Cq2TlIFj4foJWPqkza1JATLB3NTzltuKQvyZQI5JgJY0Y7v2mY5GJvDez6tME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=WkBEhsIN; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TS5HrYmK; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705942648; x=1737478648;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Bo0hrWdSRgHFLDSSP0QchiILdpicQToJNCUhwG++r6Y=;
  b=WkBEhsINlkM14sM7mMI097HDKjFuAyKHJj60A1/4BrhqZQd1GkJ/wTRC
   5cEI8bS2g1IrVJNoIKqN1F2cczd3DBS0MDZ1R/5FcxQOvqeDcDscUbKhd
   9nmT49zKitPKH+zoH/RB//WaFSBlJ0raxNTCr4OMsU7QkS6p6QFZNqeNj
   05BFTlnvniJ3AufCNBwWA52joslWQvWEJc2lLWkLj7NAfIVX5BQwpQjA9
   Od2dXsXDd756C56PqB19MVjjtS3V1vHXDuFSUW2I6bQx+qo3ntEea5cMd
   ceFZ3O2q/uTMYuq/RRlmUzoxFZ34UR2ugZmNHS1hxj2Uk3ux4GFc64ElX
   g==;
X-CSE-ConnectionGUID: 6Z/BRKnITI23ALfcZ6DSyg==
X-CSE-MsgGUID: 2RZoDavgRPaGAZrDbU4exQ==
X-IronPort-AV: E=Sophos;i="6.05,211,1701154800"; 
   d="scan'208";a="182348738"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jan 2024 09:57:27 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 09:57:13 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Jan 2024 09:57:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bg21xxOjtTPPI1HXQOPE96CTRBbXQxbePINFQWP0DE7/CS/vqfT4+n/qYqZKtUFfX7+ZLt0YYkMkeozj+jMln3Q3F8XPyd/+JAgULLn6iln/2fRpI9GQ8/1H5ehZVTAf9nrl8l/cVY2xWZoO9xQFn67jWo8512X3SJCLgeYL4dBMxPp2nIHwxx3Bsp8eMeayabcFc62a9YhEEL8qXRuVAHbnqClgRi29bK4IoAQs9KnLtfhxs8dbO3c738cFPO8JTMuzrjSRnok9UzaUQOBiADsjbSub5TTEnrhjksIhERxhzt5T2uAYMR4d5+ylAIkvLgSWhbO7V9R+zif42CphxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bo0hrWdSRgHFLDSSP0QchiILdpicQToJNCUhwG++r6Y=;
 b=cfuA3ptmd7LRKpctDW7VkNewCGVTM/CvjMnx06jeJDGFNgUpoSwvRGJr408sfEBgWoBILMCqC4pgHBYsixFLuEJCREbdZhk5rnKi3/8ZBcNBKvBa+88DRap6BZ7XS0MVvp7m6NTDMIoCJmI2D/NonoY5pXvTU5JgIyGFIGd/ElSYkLpQLKpEdj8oepGEKGJtwIkOsExjmUQ5CigvT3gPatcwkqzB30tef2q+9Lw5PgLI8oKfUmyWJDtgG+fqP3v4fQtH616QdoM6Pyt0C94CJ9Hu/lsLJzRMUDNHEBxB3/ZgIo7Yrfpb6SJdyilirvJGyhY1IrHOS9J8w9PG8m8ZlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bo0hrWdSRgHFLDSSP0QchiILdpicQToJNCUhwG++r6Y=;
 b=TS5HrYmKg/s3YCQ9RW8EzjMTGRzV+MQGnOnxpbdyujodTq4ZSzysfTnK1A5tQ8DVimK0D8vqI49tMS7TB+wPZqwWOw64z9mi31Pl+ayozmHH9jJWY2KbKwQOfK1ZjnKOa2K5yHV4LLqFAvpq8Cgd/ipcTeV1sFW5nPsZt5AcR8BOfF4zBrq27Z27vqafNAR9hPXj8dcM2Ee11e7hQLdXFRdzkRIXRaDhtKQUX1ZA+ECJL8IleTD8+/2EdPKCFRMIb6yp4Bmb8rQafJU6cOAeXon2huHwRE3L4+7SjRguStqoRLHw6Kgp2dLfuCk9Cs6jRk2DMxPCcILn67qZdY6txQ==
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by CH0PR11MB5298.namprd11.prod.outlook.com (2603:10b6:610:bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 16:57:11 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::613:fb5:737:dae8]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::613:fb5:737:dae8%7]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 16:57:10 +0000
From: <Ajay.Kathat@microchip.com>
To: <davidm@egauge.net>
CC: <linux-wireless@vger.kernel.org>, <kvalo@kernel.org>
Subject: Re: RFQ: wifi: wilc1000: make wilc1000-spi bus-probe useful
Thread-Topic: RFQ: wifi: wilc1000: make wilc1000-spi bus-probe useful
Thread-Index: AQHaSyHAGTzLKtq6YEiQxz8weQqVWrDmEc+A
Date: Mon, 22 Jan 2024 16:57:10 +0000
Message-ID: <1776feff-0886-4db8-896c-c542d3e626b0@microchip.com>
References: <90fb762e5840f9d5a6ae46f81692fb947a7796a4.camel@egauge.net>
In-Reply-To: <90fb762e5840f9d5a6ae46f81692fb947a7796a4.camel@egauge.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_|CH0PR11MB5298:EE_
x-ms-office365-filtering-correlation-id: 1d7634c6-9a44-4173-74a9-08dc1b6b2cf7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I3mQe+iAczakP9ORtT97wCVao4bzaIss7315gMofqQUq0J3m6sehH+cDGhe9S5RY3JZ7bwTCvrRj0+Ik9iLXxU5jcIVnkTjBDYVKdXcrzhfrDPyxsplBwtnak7G5JawUW9gbiZkdoggPVX3ErVtNomolY33Py2zNrfW8TshXe71s3oYiFE0uuOmO6KXMmLoETZfxMoTZ8xBL1gGxgBEGks+njC21uKliR4BCOrhGVk0ewYM2MxiOPjXmhz9Qy/7YdUurwCqwPvWOfG2OEjwdT+FNoaiKwzlSsBhl+RiQJbMn5+e1Gdl6hVwCBT4deOACn2moOmb6vuXO1pHZGBUvXhwcbK6JcxOUB8iVyu3zCOH/LJUHXkkEtwEJLmt2JbBJnaYhlW3CdpZ9XBsdWWoJT3U7OVbPHsM/spDjSgxJoxOTXYXd0tT9Y+xX5s0tXz2CUKsmXBhruNzkbHmXLvpqmyZkSoBnKQFZs60TPXDXgj3/nn3DHXACAJE/3r0H1lIBVNPflAynCCRyurYiLrRbrYzOZ4FfpJi9FnShi8sXr5wbM1rya8Uu62WmJJsjDzUrzEjvRoOMdoCW6fMHDmRqWuSc4Jc6ryiIQrDF4qW+rX48q7vUs7X7UMl3dxobjVZPH6+68tAhA2OB93APcDR1eBQ0x+GCip+e/rncC7Q4G12lgcupL//nvKiTOYpP9NcV6LQoCXNn2opLJwe+rVrLGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(366004)(346002)(230922051799003)(230173577357003)(230273577357003)(186009)(64100799003)(451199024)(1800799012)(31686004)(2616005)(26005)(6512007)(71200400001)(53546011)(38070700009)(6506007)(86362001)(31696002)(36756003)(38100700002)(41300700001)(2906002)(8936002)(4326008)(6486002)(122000001)(83380400001)(5660300002)(966005)(316002)(8676002)(76116006)(66946007)(478600001)(91956017)(54906003)(6916009)(66556008)(64756008)(66446008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDVkbE9KakwvU3JJcUhSVTN5WjdQN1dDTG1HUXI4dG56YmFvNncreVVjK1Vz?=
 =?utf-8?B?dmVON0hWVUJqcW54VEtjRC9nTDlNZ3FyNW5DczJOSVJhZFZna3liTDQrTUFw?=
 =?utf-8?B?Q0EwQ1pIclBza25IbW52SVMxNUNrRmVyWVpEdGZNWjJ0VFlSaE8vYW8ybkdq?=
 =?utf-8?B?VlFvbm1rMnJKZjNRMVpnNnJrU2Z5cjhCZVcxczA3Sm1FK0MwNHhHajF3anMr?=
 =?utf-8?B?Q1NTdWwxU2NiK01wZXMyaEZwV0kzZHhsbUxxZUdMZ2lselpZZTQvUkMxQVlZ?=
 =?utf-8?B?dCtvcW81QnRFMFROaTMxS0tZSmVnWksyQ2JxNWtIYWZhYXUrTUJNNnNuQjBM?=
 =?utf-8?B?TkRSbk9iQVp1ZlJ0LzVoRGcreXBkWEd3TUtkQkZjckVmMXNaeUJ4S2lRUmlJ?=
 =?utf-8?B?aHI3N2w1bERzYVJmVzhwQ3lBMEswa3lmTi9oZjNLU3NGVjk4aVcyczdjR3I0?=
 =?utf-8?B?UUxvOVZ4bDdzYUdobDh1WnlOYkkwUTd0azQwZmdJaUg5anl1eGowZEJXblRT?=
 =?utf-8?B?MUhzRGFGa1ZFZEdTT25OZ0h6ZzFWMWhuUU9yK0NQY1U4dVlRSW96ZnpYMnhD?=
 =?utf-8?B?UDRIaVdLWE5hdnc1RTFaQ3l4OFRqTDhDSjNYVzE2K3Q1ZUpTQlJhanJEM3Jm?=
 =?utf-8?B?aHFKZFdudnYzZFdKTnV6dm9rOWt4eEZ5RDI5TmhsaDZTSjlqbCsrMkNPandJ?=
 =?utf-8?B?c0o2RHZ3L0FrNnJNNEQ0NmlicXROWUhwNmdtSUtITzkyMnhFb1ZMWEtXZTd4?=
 =?utf-8?B?T3VoU2FqUlgyZmh0N2diU0RzTEQrdGVnY3V5ZWF5VnBhcnBKcTZtZjdVY215?=
 =?utf-8?B?WHZtdkVJOUdJTG1rYkIzQjRNSzJYL1NzeXBsdGxCOWZvdUNSZFFHalVkMVRU?=
 =?utf-8?B?UlUyQ3VKMWt6VDRKeUx6c01nVjRLMGJLTTloZ1U5YkVROEJKbFYrbzYzenlP?=
 =?utf-8?B?SHpyQlF6N1ovMXJYaUFEU1piNVJRS2dYbjRLOWlxYWNNYitsUUtWd1ZwdkQx?=
 =?utf-8?B?SmhCQVJKZWdLY1N5aHgzckp1YmpZMSthdDNzTTQwd2NQS3pjR3k4eEZsb3BK?=
 =?utf-8?B?SG5GdWNHaXpMNEVCSmhWa1J0UVdObnZpMjIybjgyVDBqeDZLWFdUVUcvSlph?=
 =?utf-8?B?VjJNYVhiUWVIN1NWaG13RjBjcHg2c2E4TDQ0T2x6QXNHOHc3em5lYUg0MFBN?=
 =?utf-8?B?Vy9qV0V5cUdkRTA3dFozakRoVU4xeWcrRWVySTVQV2RDNUxzODhSS0FyZ3g5?=
 =?utf-8?B?UHFyYWsvWVZHVW9KRUJ0dTBjL0Y4TnhhRUpNTWtoWFYwRGpBUE43WEZKVEJv?=
 =?utf-8?B?VUxnWE5TUGUvN1NBOHBDN1BNREhvdXpsODZERE83cWs5OFQxcnVicmpsYkls?=
 =?utf-8?B?RTZycXMrYTNVVjNERGN0OFgydHNiRkVIWlgySnB1ZmtHQUlHeWZYYnVheEtE?=
 =?utf-8?B?V3hYSmdRbUZNdFRudDl1akxwRXp3cWR2cHdtUXBMU3lUNEgzV0h2UkQrOUpp?=
 =?utf-8?B?cTZsNDI5YnlPZUZOL2hmQWRJQ0xhVzJyb3RiQmlpMXRBL1BXRGFUYTJNdlpN?=
 =?utf-8?B?cGZySTd3RU9pR05kZHQzYWZhWXpmZzlLZHJhdjNFd2l1L1ZjcUQxS09GNmFm?=
 =?utf-8?B?ZWRBVzV4ek5tcGdaa1VoS0RBZGhoazBEU1BoQzYwbFNCNklTL1hteTkzSGJB?=
 =?utf-8?B?a3B5YVpvbWYraFdDSmh2T1hWNDBHSXJHSWUwZ0hTekRUZjRlLzNQVHppUWd5?=
 =?utf-8?B?TytRUWpab08xSExFLzFlSkY2SlNiSFhZR3N4djN1aFhXYjU5Znh5UGZxL2Jh?=
 =?utf-8?B?RlpxZzRuTWxlcklOcEZYUXRJNFRKM0R5M3dsdDlHZ2IyQW8yV0hsWGVTRCtY?=
 =?utf-8?B?Z2hrWVFyMHp5WUJuNzlOd1QyYkNIdm5uS1VIUVYzTEZpMHp2UlZ6MVhIVzVl?=
 =?utf-8?B?d2huUFVOOXpGUTIyMU1CcjMwV2tQWEdCUmE3ZXd6OTArSTlXZzBQNUNEa3k5?=
 =?utf-8?B?UWExUkg0VWlYMWtEeUNaVzY2cnNPcnVjY2h6RjZvUlJ1ODlWSWg0VXhwbHlM?=
 =?utf-8?B?ODdscHFWQk9BbDNEMkltc2QrUFRjZ29aNTl1TkhpZFdRV0dhcmFXa1lQNmJt?=
 =?utf-8?Q?7/1P6QK06lUL9K9UwIgSjU8D/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8AC1B472F527841BC9909F42ABE81CD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7634c6-9a44-4173-74a9-08dc1b6b2cf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 16:57:10.9542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /IL5blraCRGVPXq8FJ8OyO6EerjxXuUylD2ojykOkKWaaGK/xPtXvxim3NqMAZXoU1cJ0fT0oSJ0KV2ywAOqHp36NH5wrIfzTwqBhhuvxMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5298

T24gMS8xOS8yNCAxNDo1MSwgRGF2aWQgTW9zYmVyZ2VyLVRhbmcgd3JvdGU6DQo+IEVYVEVSTkFM
IEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gVGhlIGN1cnJlbnQgdmVyc2lvbiBvZiB0
aGUgd2lsYzEwMDAgZHJpdmVyIGhhcyBhIHByb2JlIGZ1bmN0aW9uIHRoYXQgc2ltcGx5DQo+IGFz
c3VtZXMgdGhlIGNoaXAgaXMgcHJlc2VudC4gSXQgaXMgb25seSBsYXRlciwgaW4gd2lsY19zcGlf
aW5pdCgpLCB0aGF0IHRoZQ0KPiBkcml2ZXIgdmVyaWZpZXMgdGhhdCBpdCBjYW4gYWN0dWFsbHkg
Y29tbXVuaWNhdGUgd2l0aCB0aGUgY2hpcC4gVGhlIHJlc3VsdCBvZg0KPiB0aGlzIGlzIHRoYXQg
dGhlIG5ldCBkZXZpY2UgKHR5cGljYWxseSB3bGFuMCkgaXMgY3JlYXRlZCBhbmQgcmVtYWlucyBp
biBwbGFjZSBhcw0KPiBsb25nIGFzIHRoZSB3aWxjMTAwMC1zcGkgZHJpdmVyIGlzIGxvYWRlZCwg
ZXZlbiBpZiB0aGUgV0lMQzEwMDAgY2hpcCBpcyBub3QNCj4gcHJlc2VudCBvciBub3Qgd29ya2lu
Zy4NCj4gDQo+IElzIHRoZXJlIGFueSByZWFzb24gbm90IHRvIGRldGVjdCB0aGUgY2hpcCdzIHBy
ZXNlbnQgaW4gd2lsY19idXNfcHJvYmUoKT8gVGhlDQo+IHBhdGNoIGJlbG93IChyZWxhdGl2ZSB0
byA1LjE1LjE0Nykgd29ya3MgZm9yIG1lLCBidXQgcGVyaGFwcyBJJ20gbWlzc2luZw0KPiBzb21l
dGhpbmc/IFdvdWxkIGl0IG1ha2Ugc2Vuc2UgdG8gbWVyZ2Ugc29tZXRoaW5nIGFsb25nIHRoZXNl
IGxpbmVzIGludG8NCj4gbWFpbmxpbmU/DQo+IA0KDQpJIHRoaW5rIGl0IGlzIHRoZSBXSUxDIGRy
aXZlciBkZXNpZ24gdGhhdCB0aGUgZmlybXdhcmUvY2hpcCBvcGVyYXRpb25zDQphcmUgZXhlY3V0
ZWQgb25seSB3aGVuIHRoZSBuZXRkZXYgaW50ZXJmYWNlKHdsYW4wKSBpcyB1cC4gVGhlIGZpcm13
YXJlDQppcyBzdGFydGVkIG9ubHkgYWZ0ZXIgdGhlIGludGVyZmFjZSBpcyB1cC4gSG93ZXZlciwg
aXQgc2hvdWxkIGJlIG9rYXkgdG8NCnJlYWQgdGhlIHJlZ2lzdGVyIHZhbHVlcyBzaW5jZSB0aGUg
YnVzIGludGVyZmFjZSBpcyB1cC4NCg0KQXMgSSB1bmRlcnN0YW5kLCB0aGlzIGNvbmRpdGlvbiBp
cyByYWlzZWQgc2luY2UgdGhlIGF1dG8tbG9hZCBzdGFydGVkIHRvDQp3b3JrIGFmdGVyIHRoZSBw
YXRjaFsxXSwgbm93IHRoZSBkcml2ZXIgaXMgZ2V0dGluZyBsb2FkZWQgYXQgdGhlIGJvb3QtdXAN
CnRpbWUuDQpBY3R1YWxseSwgdGhlIGF1dG8tZGV0ZWN0KGhvdC1wbHVnKSBmb3IgU1BJIGJ1cyBj
YW4ndCBiZSBzdXBwb3J0ZWQgbGlrZQ0KdGhlIFNESU8gYnVzIHdoZXJlIHRoZSBkcml2ZXIgZ2V0
cyBsb2FkZWQvdW5sb2FkZWQgd2hlbiB0aGUgZGV2aWNlIGlzDQpjb25uZWN0ZWQvcmVtb3ZlZC4g
SW4gY2FzZSBvZiBTUEkgZGV2aWNlcywgdGhlIGRyaXZlciBwcm9iZSB3aWxsIGJlDQpjYWxsZWQg
YXQgdGhlIGJvb3QtdXAgdGltZSBiYXNlZCBvbiB0aGUgRGV2aWNlLXRyZWUoRFQpIGVudHJ5LiBJ
ZiB0aGUNClNQSSBkZXZpY2UgaXMgY29ubmVjdGVkIGFmdGVyIGJvYXJkIGJvb3QtdXAsIHRoZSBi
b2FyZCByZWJvb3QgaXMNCnJlcXVpcmVkIGZvciBwcm9iZSBmdW5jdGlvbiB0byBnZXQgY2FsbGVk
IGkuZS4gZXZlbiB3aWxjX2J1c19wcm9iZSgpDQpyZXR1cm5zIGZhaWx1cmUgZm9yIGZpcnN0IHRp
bWUgdGhlbiB0aGUgcHJvYmUgd2lsbCBub3QgZ2V0IGNhbGxlZCBhZ2Fpbi4NCk9uZSB3YXkgdG8g
aGFuZGxlIHRoaXMgaXMgYnkgbW9kaWZ5aW5nIHRoZSBEVCBlbnRyeSBvZiB0aGUgc3lzdGVtIHRv
DQpkZWZpbmUgd2hldGhlciB0aGUgU1BJIGRldmljZSBpcyBjb25uZWN0ZWQgb3Igbm90Lg0KDQoN
CjEuDQpodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvY29tbWl0L2YyZjE2YWU5Y2M5
Y2JhNGUzYzcwOTQxY2Y2YTY0NDNjOWVhOTIwZjQNCg0KDQpSZWdhcmRzLA0KQWpheQ0K

