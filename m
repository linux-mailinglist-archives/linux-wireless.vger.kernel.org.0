Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491A57CA884
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Oct 2023 14:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbjJPMw7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Oct 2023 08:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbjJPMw6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Oct 2023 08:52:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D92D9B
        for <linux-wireless@vger.kernel.org>; Mon, 16 Oct 2023 05:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697460777; x=1728996777;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZJIe0+SbnMkTd6WjrqRobVzoKmRJKZcvXB/zg5s/YLY=;
  b=Ul2tmUPs9K6bc0ehDuBam1XjgU0j78ceD3YFbjHa5sMFE+TZpPBYJW+e
   gL7y+oFpm5Y/7vdPi2fW+wpnjlY+lnQej62T01FZMnblCZRj23EjBlVEI
   w7nPS1RKJ9Yay0dW6r9VB6rW5FgpHyLHbTocjGPx4UUmL/77+njOV0o2q
   q5JUu1GR8fFoqMvx/xDjrT6fZAD1qE0j27y8gI52MVYoeRFvMZDCL+wHF
   uYYGNKPwaEXR67FjkeqEvkTbEZFgAGz/bgIpihPdQmOjeZnUTI6fgbjlW
   3IVT8kmQvneESpuTV8U+UhfgFMTuQ9FCNe1Ccsq+YQ7x5MLPzggcAd9uS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="389376327"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="389376327"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 05:52:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="790785744"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="790785744"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2023 05:52:38 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 05:52:38 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 16 Oct 2023 05:52:38 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 16 Oct 2023 05:52:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9aJbSxIchvcJxTcsWc60AjNJxoN0IwzdKSckK/GmrlRyIMGfRxFAX9/6W4McehASmrPN645wrtG2be/lRWHHfOvoWbsZMjBMz5jVMQg4+8MzjUry4jcs1+HS9ExuQg9L8dRaoxf8SDQ7tfmqhizn5ABzDcw6VQjuYOzznYhpH+5FPFtk6YqtRlViolhE+07y+xbKx3lehhkYE22+dGuF7sSEiQV5LVAH5VW5BEiTI11DKB/hCDsT8Si50bVFERCgy1Nq/XzUGpzIflITKrg/f1rbKgLi1qh+rs+h1jiFIKyWzfhxALE4f9ElgfdMm0A8dIC4c9uKBJsIgLtVphgxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJIe0+SbnMkTd6WjrqRobVzoKmRJKZcvXB/zg5s/YLY=;
 b=O9lha2BZEAsX3nXmR0X8oEljP6/v7X0DwY9619P4J3Za2qX9fROHFw8Hiv015IlSyqRbXKivqEtZNvAUJBynVEP38WT+8bpCx7aCoanDD0qPe+mNL2NzHxUYcViR7eMNJqSd2Cm8Kd/58M0SDN87UiU4VPimbo3vJMg5X7YVYAmV4LQv8ASRpigsKcKZ+zvMM2vmo2z0QO1q7GJgyqNsLfdS1RJTHbjaQojkPxtW4eZTChfhRjpfukO2Lydxgao+43SDeYXUfMCyZmSvywTrLdPfPU3Dz53NpnkrqAlkSv0+wy+MzYonKbiZFBkTj4kj3JTfKy4L53brPfMidIkI3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by PH8PR11MB8260.namprd11.prod.outlook.com (2603:10b6:510:1c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Mon, 16 Oct
 2023 12:52:35 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::ab8e:865b:f1b6:bca0]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::ab8e:865b:f1b6:bca0%6]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 12:52:35 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "dmantipov@yandex.ru" <dmantipov@yandex.ru>
CC:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Berg, Johannes" <johannes.berg@intel.com>
Subject: Re: [PATCH] wifi: iwlwifi: check for kmemdup() return value in
 iwl_parse_tlv_firmware()
Thread-Topic: [PATCH] wifi: iwlwifi: check for kmemdup() return value in
 iwl_parse_tlv_firmware()
Thread-Index: AQHZ+tLnOIqp5vWOx0KKf1yk0Q5tDLBMaZyA
Date:   Mon, 16 Oct 2023 12:52:35 +0000
Message-ID: <077f2b7a8dd66190270638a028d47dc2bbc6f889.camel@intel.com>
References: <20231009170453.149905-1-dmantipov@yandex.ru>
In-Reply-To: <20231009170453.149905-1-dmantipov@yandex.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|PH8PR11MB8260:EE_
x-ms-office365-filtering-correlation-id: a537d3b1-7ff8-4fbb-0f65-08dbce46c4fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VKW0SBLoxDkkiixMEHiQN4ROT5pXndXdDbgNOLChUc2XIB0kJE1yd0fpKCwSBcc9R4jkieOYvFonDak9b4U5C7VBJxm8oeZD2hX0OUnmE7WW7luw1kx2sxYC5B/izKGpB1FNBTo+2HLi0UUvKCwMUyVzcXObyfJY8YLNnNQQNZMOni1JyrpPMPHOG3V7l7MjnnIkl5yWLJCOzwypL2F2KOz5QPzrF/ljMKqm9VMEJSwn3lq/g+KbCoRrFfweshakIpIbS0U1igl7eoQsHw3J1Ii0m2Ry80L6XFohPuSb1IaVjWGJagPHuOx2Js4fS3VUzt3u4yJshhyf9t/iAVfu7qYLRkgUpsWb3vRfiGb9tcWye0dFXFF/Si5Ap9qZSKRPn2lNIPzRWxyfXKnv99wAclahBIlPQjh24P32c7MQTuwUKXsguIQQl+bZhOyYlUWXeWI5O2np5h9Tg/g2ZvHyUMlgToAdeP6SA/PngkgKbl3FFuwZTL/zGex+4xXdEs69VUV0BhBIHgV0XFedjc9kr4aON/plCyzjmiVjoiWuqZ1wzEAhwET2DKYhjrnS+Q3jNd/aUy0lDv1uM7GOLGjqYzeBN2QHTVxRHg5uH9mY4LiBcgOl8j8Zl756/ZL3bg6O
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(6512007)(38070700005)(26005)(122000001)(107886003)(2616005)(86362001)(478600001)(6486002)(5660300002)(8936002)(8676002)(2906002)(82960400001)(64756008)(54906003)(66476007)(316002)(66446008)(36756003)(6916009)(41300700001)(66946007)(4326008)(76116006)(91956017)(66556008)(71200400001)(6506007)(38100700002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHJUUHpSbll2SlhMSzAyZ0dXWW5Fck4wNmpzTDVHcVFiRHFDYVJabUw1RDNx?=
 =?utf-8?B?YjZqSlRnVHkzTVVjQmpORFdUU201dDUreTBubkh1Y2EvdHR2QnNSbll3dXZ2?=
 =?utf-8?B?UW1Gby9OOE5kSGhWSFBldEJMazd6S3pNZS9odDFKSFBpalkzeWtVNGEwRkhN?=
 =?utf-8?B?cVc1VUI0VFJjWk92c1pLeEhoODNWWndDZC9KMk8zcGNTTEg3RmdBNFlNYW9M?=
 =?utf-8?B?QzJYWml2eGFaUmRCNjN3VUZMVnlBeGt5VFBqMitFNDd6NzVsVnZ1NUdldnNT?=
 =?utf-8?B?OXVDVkF0eWtZdnVEdXBUVXo2VW5WL2p4aEVsNmYyeWdkNFdmVStnQ2dnN0x6?=
 =?utf-8?B?TCsvL09uWllneTdsa3ZQUTQySk5pVXlCU284RnJER283czZnOThuSm9wdlhH?=
 =?utf-8?B?S3NqanBEelE0c2J6UGNZTkhRdElqblR5TTk1eTZzUTBIeWtwQ1hOUjNhZmhQ?=
 =?utf-8?B?SE1JT1hJWXVjdjB4YjhpK0E4djQ5Rlp3QmczK2E3YmdRYncrd3JjWFl5S2tX?=
 =?utf-8?B?TXZTSUV6RFJ5dS9zdzFVUzJVYWtMUHpaYmwySGFzNXRDZzVnRTBaeUErd21h?=
 =?utf-8?B?dzVtbmtoWC9VVG1NQzBDU09XMjBQOFhKeUp2dnJKSXUvdFZFek42WHkyZGgy?=
 =?utf-8?B?Z0ZtSXNEUTZ0VFh0STNVekM5RTJiUXhhcE5yc3diUU1JR20yNEJGaWJDK2RM?=
 =?utf-8?B?V25DTzUrT3MySEhZOXhiWDFTQVdkTXl3NnZjN1JRdVYzSmc2OGoyY0tiUGNv?=
 =?utf-8?B?c0RqSG8zOVJhdmFJTEFWZm9FUVR5T2dOcVFlR0xjSnByMFF0UVMxeVVhOWsy?=
 =?utf-8?B?K1hLUVdyK3JrcEk3ZnFjU0ZlY3NYMTNvWVA2dFlDSnZobU1PekJxY2o3eDFV?=
 =?utf-8?B?ZFRmOXE3bFh2YlJvTk0xbHoySm4xdlBXTks1Y3B3UWJRTUlXL1pyUVZ3MlVY?=
 =?utf-8?B?U2p1R0JObTlQQng2N1hYNWxpMEI3aWxxbTVlQkk5Nk84c1JaaVhnejYvWWdW?=
 =?utf-8?B?M2hsSDVhR0RKMGVDR1NYMlBaeUJxSjFuYXdQWFh3aE0zT0RrN0YxcFl3K3Ix?=
 =?utf-8?B?cGp2NmxuS09uQW0zMzN1K1FYQjZGTUFTMDQ4N0VjcHkwL2lwSVY2MXJXQk9V?=
 =?utf-8?B?K2hnUnNFci82ODBXTTdNMysrZWZCcEkzaGNnM1JjdnN0dDltaTQ3L3Q4QmlE?=
 =?utf-8?B?aVdQTG5PalRIbjh5bjFyZk5OTUJtdXc1cTJxWERGNVhKbGRoZGMzUGxWeVNj?=
 =?utf-8?B?STFVZWpNaUs0OEY3YTM4SVkzSnRpYmdDdzZiQVRqREtma2pWWFRTTXVSZ2dh?=
 =?utf-8?B?bGdrR0JYeWZRL3pSbUFvR0RSZm10R3BGMGVKWjRtSzRLeFErekVMK25mdVhY?=
 =?utf-8?B?aE4wQ3l0QVNHVk5mQ1NOU1NhclZuM1ZDSDNyU2hXNEc4UWVzZVFocG00Y2RG?=
 =?utf-8?B?d0RaTGJFUjJBalNlZGwzanNBTlJXbmR3M1ZhODIyRnZ4d1dIcFYxa0VVVGFK?=
 =?utf-8?B?dDBjcmE1ekt3SGhENUx2Z2JuYSs4ekIyU0YzMmxDWXpTYlYyN3Bkc3JORFN3?=
 =?utf-8?B?aFZ0eFZYaFFCaStCck5MQTFxdzhVci9HYlJNS29GTmJpM3lRR3k4Vmt2UXNI?=
 =?utf-8?B?bW15MGpseEZRVCtvUHpZa21TZ2RWQ2g4bG4xaU9wODBSVzAxRHZPZS9qMjFz?=
 =?utf-8?B?eHgwSmdPVUtwaGhiVGVLNHR2b25SQm0yK3pKQk85ZnBhMnNha2xoSFgxMWpQ?=
 =?utf-8?B?SXE2U1hjaW9SVEtKS29zTXVhNWtqTk8vZlJqRUduYysxY1ZIN2c2RThZMy84?=
 =?utf-8?B?NVh4UE1sUzh2NytyUy9XS0VLY1lUQk80K2FpcldiU0hjdlRVMHAxUVhwZEhO?=
 =?utf-8?B?Ky9MMG9EMVFXa1UzWnVYWXRGSzJFMUZWc2sxTjZ4LzVJVlA5dGZsR05STm9M?=
 =?utf-8?B?YXRYN0o5V2xvVWh2OWhLYTU2LzdBLzE1Z09rYXg3Yk9RdWE1T25xSFNUak1U?=
 =?utf-8?B?UlMwL0VZUVlhcXF6UXVxckJ3bTd4Rzc3bHdUV25nNFpPZjBvb29mVG83Yklz?=
 =?utf-8?B?MzBhUXpHMmRGZG5GenltOFNyNGl2OGplTnFSdDFxUVBreE1pbWZtS0Y1SXBt?=
 =?utf-8?B?OGNnY1d3WklLc2U3YnFRSmRhRXcxUXg0aDVZZDlQZHVkQzA5MHBQazlnVTdR?=
 =?utf-8?Q?CsWyqZs9MNJG2mw0BrYLYyc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72F7AFF6E589B0499D61E498AEA9E586@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a537d3b1-7ff8-4fbb-0f65-08dbce46c4fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2023 12:52:35.0372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KfOAAmbRClAS5mbPvHZrh7C8UqN4+Kvciz5gK0n7aBfVeHT6r2NTGt1N6vOildLIDh5Earu8mShCCi8dcFD644MY/DiyXsHn+Ch7nBhrmlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8260
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gTW9uLCAyMDIzLTEwLTA5IGF0IDIwOjA0ICswMzAwLCBEbWl0cnkgQW50aXBvdiB3cm90ZToK
PiBJbiAnaXdsX3BhcnNlX3Rsdl9maXJtd2FyZSgpJywgY2hlY2sgZm9yICdrbWVtZHVwKCknIHJl
dHVybiB2YWx1ZQo+IHdoZW4gaGFuZGxpbmcgSVdMX1VDT0RFX1RMVl9DVVJSRU5UX1BDIGFuZCBz
ZXQgdGhlIG51bWJlciBvZiBwYXJzZWQKPiBlbnRyaWVzIG9ubHkgaWYgYW4gYWxsb2NhdGlvbiB3
YXMgc3VjY2Vzc2Z1bCAoanVzdCBsaWtlIGl0IGRvZXMgd2l0aAo+IGhhbmRsaW5nIElXTF9VQ09E
RV9UTFZfQ01EX1ZFUlNJT05TIGFib3ZlKS4gQ29tcGlsZSB0ZXN0ZWQgb25seS4KPiAKPiBTaWdu
ZWQtb2ZmLWJ5OiBEbWl0cnkgQW50aXBvdiA8ZG1hbnRpcG92QHlhbmRleC5ydT4KPiAtLS0KPiDC
oGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvaXdsLWRydi5jIHwgNiArKysrLS0K
PiDCoDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvaXdsLWRydi5j
IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9pd2wtZHJ2LmMKPiBpbmRleCBm
YjVlMjU0NzU3ZTcuLjZjYmExODU0NzU0OSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL25ldC93aXJl
bGVzcy9pbnRlbC9pd2x3aWZpL2l3bC1kcnYuYwo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L2ludGVsL2l3bHdpZmkvaXdsLWRydi5jCj4gQEAgLTEzMDMsMTAgKzEzMDMsMTIgQEAgc3RhdGlj
IGludCBpd2xfcGFyc2VfdGx2X2Zpcm13YXJlKHN0cnVjdCBpd2xfZHJ2ICpkcnYsCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjYXNlIElXTF9VQ09ERV9UTFZfQ1VSUkVOVF9QQzoK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAodGx2
X2xlbiA8IHNpemVvZihzdHJ1Y3QgaXdsX3BjX2RhdGEpKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIGludmFsaWRf
dGx2X2xlbjsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGRydi0+dHJhbnMtPmRiZy5udW1fcGMgPQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRsdl9sZW4gLyBzaXplb2Yoc3RydWN0
IGl3bF9wY19kYXRhKTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBkcnYtPnRyYW5zLT5kYmcucGNfZGF0YSA9Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGttZW1kdXAodGx2X2Rh
dGEsIHRsdl9sZW4sIEdGUF9LRVJORUwpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgaWYgKCFkcnYtPnRyYW5zLT5kYmcucGNfZGF0YSkKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBy
ZXR1cm4gLUVOT01FTTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGRydi0+dHJhbnMtPmRiZy5udW1fcGMgPQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRsdl9sZW4gLyBzaXplb2Yo
c3RydWN0IGl3bF9wY19kYXRhKTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBicmVhazsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRl
ZmF1bHQ6Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
SVdMX0RFQlVHX0lORk8oZHJ2LCAidW5rbm93biBUTFY6ICVkXG4iLCB0bHZfdHlwZSk7CgpBY2tl
ZC1ieTogR3JlZ29yeSBHcmVlbm1hbiA8Z3JlZ29yeS5ncmVlbm1hbkBpbnRlbC5jb20+Cg==
