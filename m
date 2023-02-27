Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8463B6A3D56
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Feb 2023 09:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjB0IgZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Feb 2023 03:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbjB0IfO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Feb 2023 03:35:14 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85AB22DD7
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 00:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677486632; x=1709022632;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QgNkCCAMo3mlsHRkbU8j1J+2DBJVr/1yPAFEXk00Du8=;
  b=cr72e/65eGU1dkLPNGbLkgMGiOTlsObHEWwh149OyOBNzlSoJt1gBg4U
   saQy5S2OXbZJGpGhVMKqNjKZWuwRtVMMRNNAfOxMd15F6DFx829Zzt1Wj
   zH5NO8FObkl5ZO+yUkgD2/rs9lm6bMetxexNOEQ4ihql87GgLgOVMeFZx
   1Aex6e7Bi5Pztb2FccyBdf2tofHBubCl9+heSS1y4iE0jpU2QtC7pTwfF
   ff3C7qpo3BmRtcfOkJ4cirnb/8Z6Cq79GHWbHD1rfb1VHZmosrovVBLq5
   hdAA376VjoY7xHeSgfZli2gLoSLIcml3AoyJkDriACZZo9TJKebXKlyFj
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="313480486"
X-IronPort-AV: E=Sophos;i="5.97,331,1669104000"; 
   d="scan'208";a="313480486"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 00:25:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="919210120"
X-IronPort-AV: E=Sophos;i="5.97,331,1669104000"; 
   d="scan'208";a="919210120"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 27 Feb 2023 00:25:47 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 27 Feb 2023 00:25:47 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 27 Feb 2023 00:25:46 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 27 Feb 2023 00:25:46 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 27 Feb 2023 00:25:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFyMm8GVLjFBprbYtd+q072hs7PmmYPuvFIapmtU5dGawmhXgen57K9le8mo7dt+MsQH24Y69c0Hi+ccXEDi9773ZysQEGXtb1gUlYCetj1sumHJ9T7XavVs4QX/JFQGoALrv5o3KNEXISLP7wKjt2IH9z2CqMziwU4+KsjNrdUT5Ra/9H78htxTNksnemlNCNidTCMT4JjV2ukbXbYGrHgAyHgwp0CWWavqRQxdstQzj4I9ZcUykJrWv+cuqPKSdplgVW0Zi8Aa8I8Y8wZ928rRYdVWESJQzK/mhxTYu51dS0NOYgU5HEG5a8I6aHyIsTV8GYQ3T/2/uVNTrloKtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QgNkCCAMo3mlsHRkbU8j1J+2DBJVr/1yPAFEXk00Du8=;
 b=F4j8YtMlwYk00PBDRJE3Rq/FiQgxKTYkcIC531I7P0/XG9sP7hIorfgtmdWO+/JuFv4KrJwoq1GRccoygPdJ/TNShlD+FjVTLj/C1MHX1OcTJMIRML+qxZNaNRmGH1SNt6R1F5uhEKZ5aY3cb/naOZilD52YvoPIRdJc6pnxVIrlRqO3pQH8fC3TTXrJl6urDExgO8zruD1VKFfRirrxDQ5EYPcKgC77wtdTpKqq7hL6g5bnQHR/cQrFDocH8uWkQ7j4TG35Ih+Bp40g11lOJS8zuChQE9q5cJShZZRFnLTa/C4NXsohHHdV6V3VIHbPCfpu6gL9Tty6W/YX3EFOoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6043.namprd11.prod.outlook.com (2603:10b6:8:62::8) by
 DM4PR11MB6019.namprd11.prod.outlook.com (2603:10b6:8:60::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.29; Mon, 27 Feb 2023 08:25:44 +0000
Received: from DM4PR11MB6043.namprd11.prod.outlook.com
 ([fe80::e6b:d633:b9aa:eaf4]) by DM4PR11MB6043.namprd11.prod.outlook.com
 ([fe80::e6b:d633:b9aa:eaf4%9]) with mapi id 15.20.6134.021; Mon, 27 Feb 2023
 08:25:44 +0000
From:   "Peer, Ilan" <ilan.peer@intel.com>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        James Prestwood <prestwoj@gmail.com>,
        "Marcel Holtmann" <marcel@holtmann.org>
CC:     "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: ath11k: Optimize 6 GHz scan time
Thread-Topic: [PATCH] wifi: ath11k: Optimize 6 GHz scan time
Thread-Index: AQHZFCz8RgAxBeF3z0ygfw3Z4uAoOa52v2EAgAD6kACADCKdAIATYWYAgADFLgCARkRfgIAAAgeAgARUq4CAAD8t4A==
Date:   Mon, 27 Feb 2023 08:25:44 +0000
Message-ID: <DM4PR11MB6043976576E564D19D122B66E9AF9@DM4PR11MB6043.namprd11.prod.outlook.com>
References: <20221220043823.20382-1-quic_mpubbise@quicinc.com>
 <5DAEA8B2-2B44-4A91-9E57-12B6C6B6C1FC@holtmann.org>
 <2861463e-a097-7efe-bc75-f13c8faf9547@quicinc.com>
 <378a1d63b3752ace7384c44d6f5184753fa7795d.camel@gmail.com>
 <0b06dea9-d5be-1edc-62ca-576398d1bcd8@quicinc.com>
 <0e7644cbfa9e4ba0d534681166ca467ea1684719.camel@gmail.com>
 <10e4b6bf-f375-e50f-063a-b44471359d25@quicinc.com>
 <56a3651e48ae621afa4c50f1ba0d9fedeefb2c31.camel@sipsolutions.net>
 <7ddf99b1-4aef-c950-f61b-ba79ed086095@quicinc.com>
In-Reply-To: <7ddf99b1-4aef-c950-f61b-ba79ed086095@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6043:EE_|DM4PR11MB6019:EE_
x-ms-office365-filtering-correlation-id: ae68fdd9-1c6c-407b-933a-08db189c38af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mO1yRXvCkw40Pv06KzyqlvhAOGydXyD3FpgGyrxXtNSn2bzq3hzjYAaB/Bgu7BZsbFjrXl2sDQK7TovxwAVRJGQev/1dZqY3HkoPJnRKF47Wwhc6gEOgrKUWpGvahoug3yujSv5mpxHv4mqzdPm7wbmJfQ+R1trRBSSPcphhtl6lNrnuaKY0/Nz0vgl+PsNmS/VaTBUHh7e7HTDDYdtoUJ9gix1bQOraWXaNIYgcNJCFdT7Sh8B1sOnodGDGJA0SAigUDeFimMh4Y9+EKUrq6pRp4CiP2AJwiB86nMkLgoUOlFxLYfkuHwLEJqZEAyB9XmkHJ/xLAaGSJ4ztxSSVsKHRPjCaDZjg3sXbd1ErYftyBBlmcGshOJi1m5bdNcmp0uCnpw9wcqCXyor6Pd01XFPsnyKaa6BP7QoGDzc4sQJKO6RK0BpdNM4PiLOrUbe9Cr8ajc67M1ZmjzHiX0b+YkfIaoPaHOaOcHruhUZuShOXDzxaOc9wSY2StSG2y3HKdOp4b564TLXuNay57VQGexp4vaAziLAV+LmIpumSZhmCADp0YkFHK1E7bcJyRl7ZuTj+kBqrO0JCxL+7CXMFCkOiWHz7arWuEI5s7BbShvJQX3/bnttGq7Vb2/C8RjVLbmDosqP1GaVWg/DTuJm3Y5FOyv+6LdlrEpt5mXhNVy8nYu69DoP88xLpUxAWh8+6rRF9SUev48+PN/q4hRRnyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6043.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199018)(478600001)(7696005)(71200400001)(54906003)(6506007)(186003)(53546011)(26005)(9686003)(316002)(110136005)(66476007)(66946007)(66556008)(64756008)(66446008)(83380400001)(76116006)(8676002)(4326008)(41300700001)(52536014)(5660300002)(8936002)(55016003)(122000001)(38100700002)(82960400001)(86362001)(33656002)(2906002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qkk2d25uTmUzZmVEQ1FkbnpwVnRScnRJdXNHa1lhRzR1aDdDOENTVXdXOHlE?=
 =?utf-8?B?RWhUV3Q5alpwTlU1RFNJZm1zVE9ycyt4SHY4Y0FwTGcrMEM4Rnp6c0Y1WWhT?=
 =?utf-8?B?WVNPSllTeUVBTjZmTzkwSjEzV1ZKbXgyRjVzaVhVYWlUcGtYSkQzdDhEV3ZZ?=
 =?utf-8?B?bkZjT2FTb1pGZVRuaGpiUEJmK1BlclpjOStvZnlDWnNSbUpuMVFPeXFpb2Ny?=
 =?utf-8?B?M0dTeFUzVzlIRDc0bnMzZVVCbVIrQ2RHS3EydlIxQVJIeThXT3hDM1c1R2dm?=
 =?utf-8?B?bnFDZTQrQUZkWktsOC80a095YVlXWGtmNGNMU1FKTVBXcmhZTzhwR2E4NUhQ?=
 =?utf-8?B?WWJNTVkxZWh5MVF3b1VIVllod0NmcnYwRThmMVN6WE50S3czRHJoeWc4eElU?=
 =?utf-8?B?aHZhcWxXREJjang0T3RuYldnSDhwSEVabko1TXNEbS9GMXdlZUVsU3dtZnlN?=
 =?utf-8?B?dGoybE4yWWFtU3BPOWFGV0NTcUtrMjlaRmUzQUpKbEphSHAzeVV4QnpuZXlj?=
 =?utf-8?B?K2xsOTZjQXBxS3VNVis2c0VQYUY0Nk9DUmxRK3J5b2R1aVNPdlNCNVFOWnZP?=
 =?utf-8?B?NDhoaTBlYkdjMDIrZkFDOUxrWmhJdkoxMG1WcG5VMTcycE1qZk45VEErZ0ty?=
 =?utf-8?B?bWFmMTJucmdjSnRqWEh6Lzd3UTdXUm9UNVE4cmlscERSdzMzNWZjWFZqZzBK?=
 =?utf-8?B?WkxIdWMrMEpRM000SUV6NnBxeEFScENHa1RpSlBaTkM4dGhuM3dkRnF3Lzht?=
 =?utf-8?B?MTI5THltZCtJemJWWms0UGVpUUxuMy9vNzc5akxxQkZCK05ENnZ6RkNZRmVX?=
 =?utf-8?B?dFhNV3J6R3pEeSszRGp3TUZhR1VwR1dSUG0razQ4SnM4bmhlR0F2bFZBQXVS?=
 =?utf-8?B?ZlVVaXN0Q1Z0QVIwaEJuMFMzaUZvVEdCYVVqQno0OXo4Mms2VFlNQXF1dWlk?=
 =?utf-8?B?Yk41ZnpTMEdzcWdKc01rKys0QkhPMVhSTVNIUzdvcUV3VXhRWkE0MjFoRTdN?=
 =?utf-8?B?YWptYVJRalR3LzJ6RU5qa0RJeEhRSTgyMjYrZ2Z5TEFGa3pJSjBNYlBFa2ow?=
 =?utf-8?B?clpxUXZlcXdpVWljZjNKdzRxU0lWWktzZ0tCQWppaVQwWCtWRVZyRFRmQXVP?=
 =?utf-8?B?Z0F5ekN6aEFWcCsxTWVvTE5WL2x6UnRheVF1cnpwYXJNVzlranFMUUlEUnRD?=
 =?utf-8?B?THBCbEQrSjBBR3NWQmZHbFJ6TXZUa1pmMk1PQ1JJVk9vdE5qTlpBdzYxWGp6?=
 =?utf-8?B?cWgvdWNmWnFoaDZmK1BqdE9qcS9vRUx2aVNDblRFL0d3d0QrenA3UDhhMkJF?=
 =?utf-8?B?UHZybGk0U0dRQVp5RG5mYWY1anF5WnpWdStrU1k2Smx1Tm1jSFN4bkZsRTdM?=
 =?utf-8?B?ckNwSHlEcG9QWnNsY1llanIya0F4ek1pNjU4NVF6bUhvVTE0VUJySnhCZmJY?=
 =?utf-8?B?UlFWcG5zS3VYSjE1VGtNZHR4OVd5dmFqZHYrdW9IcVNteEFTeGZVbUJ0NU9V?=
 =?utf-8?B?bkNHeDRaYzVFdHVvY2hXT1ZQLzVNYjhZN0xzald3SEZxV3RrdXEwL204SEZI?=
 =?utf-8?B?MUZlQXJRTGllUUlKeUZTc0lZSE8wSnVIbURqbVNkY2lLRmRHMzZ6amFHcHEz?=
 =?utf-8?B?Q1pnZ3FicXBRMnlUbUluOGFOekdSSmE4cGgvbXFENkVJWk1FenVVbmlkQ016?=
 =?utf-8?B?cnBnR0VHSG9xdlBIY1I5SGJ4QTAwN003bFpKbWZyU3hLS2h3WFdHYVl0eldM?=
 =?utf-8?B?Z2l5VHhVLzUvT3J1OEtwalNOVWQxWTYva1FHbmdPSGFVOTBaWGZvM05YNlNT?=
 =?utf-8?B?NnFRTzQ0YWhsQWRRcFZBZW1JQ2dQTmtJSEpZeC9lTnNiV0xjak1ueUcwNE1s?=
 =?utf-8?B?SytZQUdmTE1pSXE2Ynk0NzlSeTI3eWZWTVZaWTUwajhQaTlEREFZM2xvVTlU?=
 =?utf-8?B?TE44cGtkUXExZ05CNjBBejNKLzhwNzNyQW1CZ1FZbDl3M1hmdDVseEdCRWZR?=
 =?utf-8?B?ZVA1TXk0UzFoYmxpTnE5R2hHQ25FMXdQLzNGcWFDeGduV3g0OW93azZLaHVt?=
 =?utf-8?B?TERBdFA4RVpNdFJoWFlOSGR5Q2FndW9TdXRxbyt1Y0ltWHZBNjIwM2ZOcGpj?=
 =?utf-8?Q?RancGp4Kbad20iwN1ZKCsF1el?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6043.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae68fdd9-1c6c-407b-933a-08db189c38af
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 08:25:44.7427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qC3Iu3KoIvsDu2UkxzvBivQ0fJ9gScLUwY9KsueB5sZhgbYYPzrVaa+qJHHQxNvie6L2ctmeH+SShdIa436vdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6019
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFuaWthbnRhIFB1
YmJpc2V0dHkgPHF1aWNfbXB1YmJpc2VAcXVpY2luYy5jb20+DQo+IFNlbnQ6IE1vbmRheSwgRmVi
cnVhcnkgMjcsIDIwMjMgMDY6MjQNCj4gVG86IEpvaGFubmVzIEJlcmcgPGpvaGFubmVzQHNpcHNv
bHV0aW9ucy5uZXQ+OyBKYW1lcyBQcmVzdHdvb2QNCj4gPHByZXN0d29qQGdtYWlsLmNvbT47IE1h
cmNlbCBIb2x0bWFubiA8bWFyY2VsQGhvbHRtYW5uLm9yZz4NCj4gQ2M6IGF0aDExa0BsaXN0cy5p
bmZyYWRlYWQub3JnOyBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc7IFBlZXIsIElsYW4N
Cj4gPGlsYW4ucGVlckBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHdpZmk6IGF0
aDExazogT3B0aW1pemUgNiBHSHogc2NhbiB0aW1lDQo+IA0KPiBPbiAyLzI0LzIwMjMgMzo0NSBQ
TSwgSm9oYW5uZXMgQmVyZyB3cm90ZToNCj4gPiBPbiBGcmksIDIwMjMtMDItMjQgYXQgMTU6Mzgg
KzA1MzAsIE1hbmlrYW50YSBQdWJiaXNldHR5IHdyb3RlOg0KPiA+PiBPbiAxLzEwLzIwMjMgMTA6
MzUgUE0sIEphbWVzIFByZXN0d29vZCB3cm90ZToNCj4gPj4+IE9uIFR1ZSwgMjAyMy0wMS0xMCBh
dCAxMDo0OSArMDUzMCwgTWFuaWthbnRhIFB1YmJpc2V0dHkgd3JvdGU6DQo+ID4+Pj4gT24gMTIv
MjkvMjAyMiAyOjUyIEFNLCBKYW1lcyBQcmVzdHdvb2Qgd3JvdGU6DQo+ID4+Pj4+IEhpIE1hbmlr
YW50YSwNCj4gPj4+Pj4+IEJ5IHRoZSB3YXksIHVzZXJzcGFjZSBpdHNlbGYgc2VsZWN0cyB0aGUg
ZnJlcXVlbmNpZXMgdG8gc2Nhbiwgbm90DQo+ID4+Pj4+PiB0aGUgZHJpdmVyLg0KPiA+Pj4+Pj4N
Cj4gPj4+Pj4+IElmIHdlIHNlZSB0aGUgc3BsaXQgc2NhbiBpbXBsZW1lbnRhdGlvbiBpbiBjZmc4
MDIxMSwgdGhpcyBpcyB0aGUNCj4gPj4+Pj4+IGhvdyBpdCBpcyBpbXBsZW1lbnRlZC4gSWYgTkw4
MDIxMV9TQ0FOX0ZMQUdfQ09MT0NBVEVEXzZHSFoNCj4gaXMNCj4gPj4+Pj4+IHNldCwgaXQgc2Vs
ZWN0cyBhbGwgUFNDIGNoYW5uZWxzIGFuZCB0aG9zZSBub24tUFNDIGNoYW5uZWxzIHdoZXJlDQo+
ID4+Pj4+PiBSTlIgSUUgaW5mb3JtYXRpb24gaXMgZm91bmQgaW4gdGhlIGxlZ2FjeSBzY2FuIHJl
c3VsdHMuIElmIHRoaXMNCj4gPj4+Pj4+IGZsYWcgaXMgbm90IHNldCwgYWxsIGNoYW5uZWxzIGlu
IDYgR0h6IGFyZSBpbmNsdWRlZCBpbiB0aGUgc2Nhbg0KPiA+Pj4+Pj4gZnJlcSBsaXN0LiBJdCBp
cyB1cHRvIHVzZXJzcGFjZSB0byBkZWNpZGUgd2hhdCBpdCB3YW50cy4NCj4gPj4+Pj4NCj4gPj4+
Pj4NCj4gPj4+Pj4gVGhpcyBpc24ndCB5b3VyIHByb2JsZW0sIGJ1dCBpdCBuZWVkcyB0byBiZSBz
YWlkOg0KPiA+Pj4+Pg0KPiA+Pj4+PiBUaGUgbmw4MDIxMSBkb2NzIG5lZWQgYW5kIHVwZGF0ZSB0
byByZWZsZWN0IHRoaXMgYmVoYXZpb3IgKG9yDQo+ID4+Pj4+IHJlbW92ZSB0aGUgUFNDIGxvZ2lj
KS4gSU1PIHRoaXMgaXMgcmVhbGx5IHdlaXJkIHRoYXQgdGhlIGtlcm5lbA0KPiA+Pj4+PiBzZWxl
Y3RzIFBTQydzIGJhc2VkIG9uIHRoZSBjby1sb2NhdGVkIGZsYWcuIFRoZSBkb2NzIGRvbid0DQo+
ID4+Pj4+IGRlc2NyaWJlIHRoaXMgYmVoYXZpb3IgYW5kIHRoZSBmbGFnJ3MgbmFtZSBpcyBtaXNs
ZWFkaW5nIChpdHMgbm90DQo+ID4+Pj4+IFNDQU5fRkxBR19DT0xPQ0FURURfQU5EX1BTQ182R0ha
KSA6KQ0KPiA+Pj4+Pg0KPiA+Pj4+DQo+ID4+Pj4gU29ycnkgZm9yIHRoZSBsYXRlIHJlcGx5LCBJ
IHdhcyBvbiB2YWNhdGlvbi4NCj4gPj4+Pg0KPiA+Pj4+IFdoYXQgeW91IHNhaWQgbWFrZSBzZW5z
ZS4gVGhlIGV4aXN0aW5nIGZsYWcgc2hvdWxkIG5vdCBhZGQgUFNDDQo+ID4+Pj4gY2hhbm5lbHMg
YWNjb3JkaW5nIHRvIHRoZSBmbGFnIGRlc2NyaXB0aW9uLg0KPiA+Pj4+DQo+ID4+Pj4gV2UgY2Fu
IGFkZCBhbm90aGVyIGZsYWcgc29tZXRoaW5nIGxpa2UgeW91IHBvaW50ZWQgb3V0DQo+ID4+Pj4g
U0NBTl9GTEFHX0NPTE9DQVRFRF9BTkRfUFNDXzZHSFogYW5kIGluY2x1ZGUgUFNDIGNoYW5uZWxz
IGlmDQo+IHRoaXMNCj4gPj4+PiBmbGFnIGlzIHNldC4gV2hhdCBkbyB5b3Ugc2F5Pw0KPiA+Pj4N
Cj4gPj4+IEknbSBubyBhdXRob3JpdHkgaGVyZSwganVzdCB3YW50ZWQgdG8gcG9pbnQgdGhpcyBv
dXQuIFRoaXMgaXMNCj4gPj4+IHNvbWV0aGluZyB0aGF0IHdvdWxkIG5lZWQgdG8gYmUgaW4gbWFj
ODAyMTEgdGhvdWdoLCBub3QganVzdCBhIHNwZWNpZmljDQo+IGRyaXZlci4NCj4gPj4+IEl0IHdv
dWxkIGJlIHVwIHRvIHRoZSBtYWludGFpbmVycyBhbmQgd291bGQgcmVxdWlyZSBjaGFuZ2luZyB0
aGUNCj4gPj4+IGJlaGF2aW9yIG9mIHRoZSBleGlzdGluZyBmbGFnLCB3aGljaCB0aGVuIGNoYW5n
ZXMgYmVoYXZpb3IgaW4NCj4gPj4+IHdwYV9zdXBwbGljYW50L2hvc3RhcGQuIFNvIGl0cyBzb21l
d2hhdCBpbnRydXNpdmUuDQo+ID4+Pg0KPiA+Pj4gQnV0IHBlcnNvbmFsbHkgSSdkIGJlIGZvciBp
dC4gQW5kIGp1c3QgcmVxdWlyZSB1c2Vyc3BhY2UgaW5jbHVkZQ0KPiA+Pj4gUFNDJ3MgbGlrZSBh
bnkgb3RoZXIgY2hhbm5lbHMgaWYgdGhleSBuZWVkIHRob3NlLg0KPiA+Pj4NCj4gPj4NCj4gPj4g
SGkgSm9oYW5uZXMsDQo+ID4+DQo+ID4+IFdoYXQgaXMgeW91ciBvcGluaW9uIG9uIHRoZSBjaGFu
Z2VzIGJlaW5nIHByb3Bvc2VkIHRvIHRoZSA2IEdIeiBzY2FuDQo+ID4+IGluDQo+ID4+IGNmZzgw
MjExIHRoYXQgaXMgYmVpbmcgZGlzY3Vzc2VkIGluIHRoaXMgdGhyZWFkPw0KPiA+Pg0KPiA+DQo+
ID4gSSBkb24ndCB0aGluayB3ZSBjYW4vc2hvdWxkIGNoYW5nZSB0aGUgc2VtYW50aWNzIG9mIGFu
IGV4aXN0aW5nIGZsYWcNCj4gPiBub3csIGJ1dCB3ZSBjYW4gY2VydGFpbmx5IHVwZGF0ZSB0aGUg
ZG9jdW1lbnRhdGlvbiB0byBtYXRjaCB0aGUNCj4gPiBpbXBsZW1lbnRhdGlvbiwgYW5kIGFkZCBt
b3JlIGZsYWdzIHRvIG1ha2UgaXQgbW9yZSBmbGV4aWJsZS4NCj4gPg0KPiA+IGpvaGFubmVzDQo+
IA0KPiBTdXJlLCBtYWtlcyBzZW5zZS4gSSdsbCBtYWtlIHRoZSBjaGFuZ2VzIGFuZCBzZW5kIHRo
ZW0gb3V0IGZvciByZXZpZXcuDQo+IA0KDQpTb3JyeSBmb3Igam9pbmluZyB0aGlzIHRocmVhZCBs
YXRlLiBJIGFncmVlIHRoYXQgdGhlIGRvY3VtZW50YXRpb24gb2YgdGhlIE5MODAyMTFfU0NBTl9G
TEFHX0NPTE9DQVRFRF82R0haDQpmbGFnIGNhbiBiZSB1cGRhdGVkLCBidXQgRldJVywgSSB3YW50
IHRvIGNsYXJpZnkgdGhlIGludGVudGlvbiBiZWhpbmQgdGhpcyBmbGFnOg0KDQpGaXJzdCwgdGhl
IGxvZ2ljIHdvdWxkIGFsd2F5cyBzY2FuIG9ubHkgdGhlIGNoYW5uZWxzIHJlcXVlc3RlZCBieSB1
c2VyIHNwYWNlLCBzbyBpZiB0aGUgUFNDIGNoYW5uZWxzIGFyZQ0Kbm90IGluY2x1ZGVkIHRoZXkg
d291bGQgbm90IGJlIHNjYW5uZWQuDQoNClNlY29uZCwgdGhlIGludGVudGlvbiBvZiB0aGUgTkw4
MDIxMV9TQ0FOX0ZMQUdfQ09MT0NBVEVEXzZHSFogZmxhZyB3YXMgdG8gaW5kaWNhdGUgdG8gdGhl
IGtlcm5lbCB0aGF0DQpiZWZvcmUgZ29pbmcgdG8gc2NhbiB0aGUgNkdIeiBjaGFubmVscyBpdCBz
aG91bGQgZmlyc3Qgc2NhbiB0aGUgMkdIei81R0h6IGJhbmRzIHN1Y2ggdGhhdCBpdCB3b3VsZCBy
ZXRyaWV2ZSBpbmZvcm1hdGlvbg0KYWJvdXQgdGhlIGNvbGxvY2F0ZWQgQVBzLCBzbyBldmVudHVh
bGx5IGl0IHdvdWxkIG9ubHkgc2NhbiB0aGUgZ2l2ZW4gUFNDIGNoYW5uZWxzIGFuZCB0aGUgY2hh
bm5lbHMgb24gd2hpY2ggY29sbG9jYXRlZCBBUHMNCmFyZSBmb3VuZCAoaW4gd2hpY2ggY2FzZSBk
aXJlY3QgcHJvYmluZyBvZiB0aGVzZSBBUHMgaXMgZXhwZWN0ZWQpLg0KDQpXaGlsZSB0aGUgUFND
IGNoYW5uZWxzIGNvdWxkIGhhdmUgYmVlbiBzY2FubmVkIHRvZ2V0aGVyIHdpdGggdGhlIDJHSHov
NUdIeiBjaGFubmVscywgc2luY2UgY29sbG9jYXRlZCBBUHMgbWlnaHQgYWxzbyByZXNpZGUNCm9u
IFBTQyBjaGFubmVscywgd2Ugd2FudGVkIHRvIGF2b2lkIHNjYW5uaW5nIFBTQyBjaGFubmVscyB0
d2ljZSwgc28gdGhpcyBpcyB3aHkgdGhleSBhcmUgc2Nhbm5lZCBvbmx5IGFmdGVyIHRoZSBzY2Fu
IG9uIGxlZ2FjeQ0KYmFuZHMuDQoNCkhvcGUgdGhpcyBoZWxwcywNCg0KSWxhbi4NCg0KDQoNCg0K
DQoNCg==
