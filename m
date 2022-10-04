Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784865F41F4
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Oct 2022 13:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiJDL1Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Oct 2022 07:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiJDL1Y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Oct 2022 07:27:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF892BE2F
        for <linux-wireless@vger.kernel.org>; Tue,  4 Oct 2022 04:27:23 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294AoTZk021298;
        Tue, 4 Oct 2022 11:27:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=U/qK7NsEdNSVY93mg990/GZh4nxvrY7neyOone6cXfo=;
 b=Xk6SaCCl+RVaHfIhx42HRmHIZbML05voAltxSkd4UXL65/5YZZdFwK5kFhhiOO9BVC4S
 tqiiOUPrLP3oR9FqgZzp8GV3he3BD6vUQpC1rCe9lIgP9IwAJxlqR8dHHx7VZPiO9wIl
 W6Kr8hxUHkHWBfrssTik3GOd8+vAtunPHMy+F7+XQ+Syf4VwcHiqwC8Jy5RzIgx8VfDT
 GtRkF1VhZAkiZReWCFf6QVPPaRSjg/0V02ORdBGJNzePXUXgYUN43U3DYj535CVwu0u6
 gAWjl/5qNtb1Ixa3ACuKSRSjMRw8TPT+Wj5/o7f5ryRclEXZQ3HkfJkkPOVFmkboxS0v EA== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jxcjfdusm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 11:27:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9ih1iGRoF4NEqiSck6+BmcccLNGrc+M6F9sso3tSSceXYGyI0ebgP/ihV+94QPbMPaU4TxWbdgHuWUvn+n/S4f1VtqpTp3bQU0cqaUBoFST9sjYPAj4jVg/lH9PrWUT/RWdGD6f8oI1ZIyxL2Af3dqP8CcR37w9Cny++CMkHUmXCNYGmFaWmhuLLfIQEgkqhDVZ9Hlt/yE/l60d7e5IrLHR+Rf6Nb9wPot2RyNhQUmjWGWY5X/cdKrW+RJmT4Mq6sYKiSVxtR4SYJFzB+nCj8eUYsA2j5kmreaRnbuA+O6+mjGfJG6U5AjJqJ1+UA+S+Z/1Jr92Cqe3RnqOqxzg4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/qK7NsEdNSVY93mg990/GZh4nxvrY7neyOone6cXfo=;
 b=jpT/pdpeF0xC0FFV/odTUVDNmPqUq5/avzJDMngfpArs2N/vViEhIXmaVXpQ2UEbZRARbeIiGxXve0nVaQi0cT5DjBKT5r+XAFntw7yxH2/Wr7Qil6TW62x9XhKufqFDDMk3QiDYRKsF4AqiRKVmAqt++8SKbKqye2c/WekXMr7IyIt+o7CnL9zOYCbImTdwieP3QLfuyNrggysKjb9D+1vmQp4KA3nt2E1mAUuXvT1MfpDR8P8U/eF9ih8j4gSPJLfmhHRm5AcXIc+YjF1WOFC/6lsCgyJMJ3IpKoNqvTbLBdOsu+RCsIfGzgMLiVxH/+37hK5yGWMp7TO8Wx5lzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CH0PR02MB8212.namprd02.prod.outlook.com (2603:10b6:610:eb::20)
 by BY5PR02MB6722.namprd02.prod.outlook.com (2603:10b6:a03:209::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Tue, 4 Oct
 2022 11:27:13 +0000
Received: from CH0PR02MB8212.namprd02.prod.outlook.com
 ([fe80::a2aa:7ce8:a34:fdb1]) by CH0PR02MB8212.namprd02.prod.outlook.com
 ([fe80::a2aa:7ce8:a34:fdb1%6]) with mapi id 15.20.5676.031; Tue, 4 Oct 2022
 11:27:13 +0000
From:   "Karthikeyan Periyasamy (QUIC)" <quic_periyasa@quicinc.com>
To:     "Jeff Johnson (QUIC)" <quic_jjohnson@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
Subject: RE: [PATCH 28/50] wifi: ath12k: add htc.h
Thread-Topic: [PATCH 28/50] wifi: ath12k: add htc.h
Thread-Index: AQHYrmYj6N49z2GeqE2IO+ZJJkKX2a21MTIAgEk5hoA=
Date:   Tue, 4 Oct 2022 11:27:13 +0000
Message-ID: <CH0PR02MB821203B4CACFE1C1CE51587FF65A9@CH0PR02MB8212.namprd02.prod.outlook.com>
References: <20220812161003.27279-1-kvalo@kernel.org>
 <20220812161003.27279-29-kvalo@kernel.org>
 <b46f6c1c-0b3d-0960-b655-46567ede41d0@quicinc.com>
In-Reply-To: <b46f6c1c-0b3d-0960-b655-46567ede41d0@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB8212:EE_|BY5PR02MB6722:EE_
x-ms-office365-filtering-correlation-id: 2be98795-f929-4fd8-1145-08daa5fb6292
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2LyleyVjOsEBebMQMNL4DZMnx0biyONkHwYSnf+rVRhuOJ+mymD4ne7hjx4nDGoa58Rc07PehmSjxEBIRi1OE6INJuR+F0m7ke6KhRKiKPunrEpQS4FuM/Jve1GkATtRgCoo5TaFfKnxRopAZ81RCkdL96SM+ZjxKx/rOlTvTT3mbf+UQo7DvNj9JNfIrTfSfSAGbReZZgANc3+71moDgVaM+K44oDBpaeZfhQ5jZALXXlcQRU8dHXi+l1JoATLgAvc2tCw4X/bhHTapNDcRqMvCTxtvgltMVIVUxqg2SwaamqWbWP5c1MUJBuhE40libRoms7I5sUx3xo4RWP+dnX2CZbw5TcR4hcEB478obSv3bwfgB0brxAEI+3Tv+fbFyS2B2tISWqNhj12myrMZqk8mKZngbUNhsYQUATnzw7AvyFzhEEocmba9M6bEmUUTCLUD/w14l71TMVHmmN5iV8hMWUGpfyUlpe3Q+5gDVN7DnXkeSlPwcdLjMrEjkaV9D8Cq+Z+2R64W5OTsVPIDDU+jFFzy2wYZaY+1+iOLwfxkbwWGI8YxnT5r9Ny2LAlFtvtnFnVaSZPoBk1ZT2hpYXRmOf829bOQwkpXaiI7DLa8952vPNFyiCwZOLR6uT8tBPSqK6daro7m7qHH9IxoNTPeYaKGIpionor8s3wNAzU51s/0CF2lh4UCWGLSb+STXzDhZ0pIsCKK0QzeI5RVoTX11bhVZS9aYldtoreu/AMAC4eQAkuqUQSKZ1spDokKSXCVa5Hf/1Bs+DTfhuWGA/h+2oE/bxyfODF2+3lwaCs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8212.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(451199015)(5660300002)(52536014)(8936002)(41300700001)(55016003)(2906002)(53546011)(26005)(6506007)(76116006)(38070700005)(86362001)(38100700002)(9686003)(7696005)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(71200400001)(478600001)(83380400001)(110136005)(186003)(316002)(122000001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aElUMk95S1F2NzdwQ3FFWUJBWnlxMkZYOXU1RGUyYXdnYS9QUGN5Tk5YUHNM?=
 =?utf-8?B?elQ1U2crZnhVTFRsVTFMZGl5NG1PYU9DZ21oRHh2NG9wQ3U0ZHpVUEMvTmlL?=
 =?utf-8?B?YVg5M3hQck9UU2ZyMWEwWi93MnR1eXdQT1dndDFXOHlGeXA4THVxMTgrZlo3?=
 =?utf-8?B?TDl2VlhWeWFFSVBiQXM5N0ZLZ2ZkT1RCYTdmMEZKOTIva1VkMWN0b3lka0ZW?=
 =?utf-8?B?QVdDd1lZancwcE43aldsYU1NUy9PaW1abG1DTjA4YUdwdTVSelZjQzFCNWV3?=
 =?utf-8?B?S2R4R2V5TXlETk9CdzBteEtiZGphVzE1MkxydE5UbDBTMHJmQmsveUNVc2Jp?=
 =?utf-8?B?M1NDUEdFRUVYSE5FdVJCMXpiQXVrRzNabVVmLzc4Vms5RCt2TGRpS2JnWmk3?=
 =?utf-8?B?TTl1UGNjL3pqWDFtcUxhckI3cHc1S3pzR1RvYmpQYTlhR2NwRUFvVk1xQ2pO?=
 =?utf-8?B?L1l0dXdkQmNvdUxHUjcwcXlGRGpuSW5UNVVkWlpQNGFKQjBnZW51ZWRMVHVu?=
 =?utf-8?B?Rmo3QjRjMGtPTGU3RHZlQnU2WlhVNG81UHZUMHJqc0kxd1VINWxKUlo2d2kw?=
 =?utf-8?B?cjBUbCtienZ0L203ajZpcEh5QXlzQ2FGeHVMREI3UW1rRWgwank1ejMwVnhz?=
 =?utf-8?B?dHgzSUJGdDlPQmRrNEN0MWpwUjRmRDA5bFpWZWpZdmZSMFhmL09ZYkZ2akhP?=
 =?utf-8?B?cEdrUVFKR2NRSDBxN2VJRm1DOE9VWFppY2FCOGYvRVczbXdKdmI0c244dlpB?=
 =?utf-8?B?ajJ3a0RUeG5Gd0dieVNKQmJmSXNyVCt2M3ZmWDUzN01CZjMwSEtSWDROU3J3?=
 =?utf-8?B?MjBHVUszbTlwYVo1NmhxTkhneTIzVnlhRk92UERzdEtsNmVOeE52cGZ5V1Y0?=
 =?utf-8?B?ekM3R0tITjV6V1RXWlYvQks0eDZvQW5MYk1lTkkwUHdiYS9qdC9pSm5PaDFr?=
 =?utf-8?B?MGN1dGVRQ082WU9aS0Z3UlhIelRLRUE4d05Jdll1bkMwWXE1a0lpVkE5dCtD?=
 =?utf-8?B?c0llV0crUjFLVTVPZ09sRTdjVGJxUEZBc0tsWkFpZ1ZTbDZYOEl2TEhCdU5H?=
 =?utf-8?B?c0pBalVzY3NxMUFqekdvUzNsazdaZXFtRTBaRkRXUm5vZnUyaEhBQTU1cVZI?=
 =?utf-8?B?QkN2UjZURTdPWkk3STFiVlJSTmNtclFWclhlWVlLN3B0VHNUeFNha3VQT3Bw?=
 =?utf-8?B?VGJiNHZkRno3SSs1TW5vUmczb0pkUGkvbE4zaE0rSzVqT1h4OWJheWcrRWJC?=
 =?utf-8?B?UEtPc2Nucyt2ekw3aXVDdlIwNkgyTUxqbVZIMHRBVXBGOXNNSE5FUVJuMG9h?=
 =?utf-8?B?U2wwemoxRFFPWklJVzhqSjFNa3IrUmtCNlN5U09PM01Tbi9EcWozSDE5T1dZ?=
 =?utf-8?B?ZS9rZFgvMUp5eUZKWTZjS3BlUFNNQmozREFKQllGblJPdzZ5RTlKL3ZzVy9l?=
 =?utf-8?B?cDUwQnlwS2Z3bmRrMzMzczRzdVpYYTFKcmJLaEdwTkhUVUxzQ0ZXU0RPUWU4?=
 =?utf-8?B?a09ZaTVWbXBLSzhCeUxFK0N0a0F3aHlvOXFoSUpjYWw1TUI3UXJTYkx3aTJi?=
 =?utf-8?B?ZVVIcllLU0dOY1I5c1pZM0h5ZGlTbzQ4OE5JRUx3MWxuUFFTYUZoK2J1U0Vv?=
 =?utf-8?B?SUFNRUpzV1ZUYU5jZU5LK1pTcFI0Y2w5bTBueUh3TUhBWkN6T1BKVG1oUVho?=
 =?utf-8?B?TWFjRmo2amZFUUJrTk1QcWpnSFAzQ3VvUXA2aWhJQUJ2OWN5dFExbFJQNERM?=
 =?utf-8?B?RURiaWFtOUZyK2pkNFFPcS82amhmcXdkU3pUdFZWV3lJL0x2UkRkd1FiOWlE?=
 =?utf-8?B?QlV4NjlJbjRNdkVJWGJCcmtVL1BGYmljVjZkSzVqMitYUUZtaUNJZ1E2TEE4?=
 =?utf-8?B?cEZSOG5IblAvWWd6SXI2SjRPK0lVTHNwZkZQWU1zUFhMamN4eURiS3NLbFc5?=
 =?utf-8?B?MGVHTW9iSytiMHlvazRpL1c3TlU3MnlZWUZSRzlhT3d6TDkrTG1ranl0OVMx?=
 =?utf-8?B?YkwzT2I5K0FyT1cyUGRrL3YxY3VzTEIyOHA0bjY5ODFacU53Z3k0TUxCYTBS?=
 =?utf-8?B?enR5ZVYvU3RiQ2J4MWVPSUdwUmJaN3JVbHJYcUpubnR4VE9QL0V3S3pHamw0?=
 =?utf-8?Q?B19o7g9/riNrCNHum5JmKpLoL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8212.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be98795-f929-4fd8-1145-08daa5fb6292
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 11:27:13.5304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wmoakr2R7byVbSGuVxfEmCIAhop7hN7waE70crSdRhGCLP8Jw8BwlHzMf9es7SJsZ6I27Nbn5BijRDMvuGq7DzoZ1LxQ1a7F2pBTA/n20gE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6722
X-Proofpoint-GUID: oHZFZdY_tRX3Bib0CgwBC4_lcF9rpm9U
X-Proofpoint-ORIG-GUID: oHZFZdY_tRX3Bib0CgwBC4_lcF9rpm9U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_04,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=580
 mlxscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 phishscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210040074
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKZWZmIEpvaG5zb24gPHF1aWNf
ampvaG5zb25AcXVpY2luYy5jb20+DQo+IFNlbnQ6IEZyaWRheSwgQXVndXN0IDE5LCAyMDIyIDI6
NDEgQU0NCj4gVG86IEthbGxlIFZhbG8gPGt2YWxvQGtlcm5lbC5vcmc+OyBsaW51eC13aXJlbGVz
c0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGF0aDEya0BsaXN0cy5pbmZyYWRlYWQub3JnDQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggMjgvNTBdIHdpZmk6IGF0aDEyazogYWRkIGh0Yy5oDQo+IA0KPiBX
QVJOSU5HOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIFF1YWxjb21tLiBQ
bGVhc2UgYmUgd2FyeQ0KPiBvZiBhbnkgbGlua3Mgb3IgYXR0YWNobWVudHMsIGFuZCBkbyBub3Qg
ZW5hYmxlIG1hY3Jvcy4NCj4gDQo+IE9uIDgvMTIvMjAyMiA5OjA5IEFNLCBLYWxsZSBWYWxvIHdy
b3RlOg0KPiA+IEZyb206IEthbGxlIFZhbG8gPHF1aWNfa3ZhbG9AcXVpY2luYy5jb20+DQo+ID4N
Cj4gPiAoUGF0Y2hlcyBzcGxpdCBpbnRvIG9uZSBwYXRjaCBwZXIgZmlsZSBmb3IgZWFzaWVyIHJl
dmlldywgYnV0IHRoZQ0KPiA+IGZpbmFsIGNvbW1pdCB3aWxsIGJlIG9uZSBiaWcgcGF0Y2guIFNl
ZSB0aGUgY292ZXIgbGV0dGVyIGZvciBtb3JlDQo+ID4gaW5mby4pDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBLYWxsZSBWYWxvIDxxdWljX2t2YWxvQHF1aWNpbmMuY29tPg0KPiA+IC0tLQ0KPiA+
ICAgZHJpdmVycy9uZXQvd2lyZWxlc3MvYXRoL2F0aDEyay9odGMuaCB8IDMxMQ0KPiArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMzExIGlu
c2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9h
dGgvYXRoMTJrL2h0Yy5oDQo+ID4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9hdGgvYXRoMTJrL2h0
Yy5oDQo+IA0KPiBzbmlwDQo+IA0KPiA+ICsjZGVmaW5lIEFUSDEyS19IVENfQ09OTl9GTEFHU19U
SFJFU0hPTERfTEVWRUxfTUFTSw0KPiBHRU5NQVNLKDEsIDApDQo+ID4gKyNkZWZpbmUgQVRIMTJL
X0hUQ19DT05OX0ZMQUdTX1JFQ1ZfQUxMT0MgR0VOTUFTSygxNSwgOCkNCj4gPiArDQo+ID4gK2Vu
dW0gYXRoMTJrX2h0Y19jb25uX2ZsYWdzIHsNCj4gPiArICAgICBBVEgxMktfSFRDX0NPTk5fRkxB
R1NfVEhSRVNIT0xEX0xFVkVMX09ORV9GT1VSVEggICAgPQ0KPiAweDAsDQo+ID4gKyAgICAgQVRI
MTJLX0hUQ19DT05OX0ZMQUdTX1RIUkVTSE9MRF9MRVZFTF9PTkVfSEFMRiAgICAgID0gMHgxLA0K
PiA+ICsgICAgIEFUSDEyS19IVENfQ09OTl9GTEFHU19USFJFU0hPTERfTEVWRUxfVEhSRUVfRk9V
UlRIUyA9DQo+IDB4MiwNCj4gPiArICAgICBBVEgxMktfSFRDX0NPTk5fRkxBR1NfVEhSRVNIT0xE
X0xFVkVMX1VOSVRZICAgICAgICAgPSAweDMsDQo+IA0KPiBpdCBzZWVtcyBzdHJhbmdlIHRvIGNh
bGwgYSAyLWJpdCBmaWVsZCBhIGZsYWcNCg0KU3VyZSB3aWxsIGFkZHJlc3MgdGhpcyBjb21tZW50
IGluIHRoZSBuZXh0IHZlcnNpb24gb2YgdGhlIHBhdGNoDQoNCj4gDQo+ID4gKyAgICAgQVRIMTJL
X0hUQ19DT05OX0ZMQUdTX1JFRFVDRV9DUkVESVRfRFJJQkJMRSAgICA9IDEgPDwgMiwNCj4gPiAr
ICAgICBBVEgxMktfSFRDX0NPTk5fRkxBR1NfRElTQUJMRV9DUkVESVRfRkxPV19DVFJMID0gMSA8
PCAzIH07DQo+IA0KPiBhbmQgaXQgc2VlbXMgc3RyYW5nZSB0byBoYXZlIGFuIGVudW0gd2hpY2gg
aW5jb3Jwb3JhdGVzIHRoZSB2YWx1ZXMgb2YgdGhlDQo+IEFUSDEyS19IVENfQ09OTl9GTEFHU19U
SFJFU0hPTERfTEVWRUxfTUFTSyBhbG9uZyB3aXRoDQo+IGRlZmluaXRpb25zIG9mIG90aGVyIG1h
c2sgZmxhZ3MuDQo+IA0KPiBwZXJoYXBzIHRoZXNlIHdvdWxkIGJlIG1vcmUgbG9naWNhbGx5IGRl
ZmluZWQgYXMgbWFjcm9zIGp1c3QgYWZ0ZXINCj4gQVRIMTJLX0hUQ19DT05OX0ZMQUdTX1RIUkVT
SE9MRF9MRVZFTF9NQVNLOg0KPiAjZGVmaW5lIEFUSDEyS19IVENfQ09OTl9GTEFHU19USFJFU0hP
TERfTEVWRUxfTUFTSw0KPiBHRU5NQVNLKDEsIDApICNkZWZpbmUNCj4gQVRIMTJLX0hUQ19DT05O
X0ZMQUdTX1JFRFVDRV9DUkVESVRfRFJJQkJMRSBCSVQoMikgI2RlZmluZQ0KPiBBVEgxMktfSFRD
X0NPTk5fRkxBR1NfRElTQUJMRV9DUkVESVRfRkxPV19DVFJMIEJJVCgzKQ0KPiANCj4gYW5kIHRo
ZW4gcmVuYW1lIGF0aDEya19odGNfY29ubl9mbGFncyB0byBiZSBtb3JlIHNwZWNpZmljIHRoYXQg
aXQganVzdCBoYXMNCj4gdGhyZXNob2xkIGxldmVsIHZhbHVlcz8NCj4gDQoNClN1cmUgd2lsbCBh
ZGRyZXNzIHRoaXMgY29tbWVudCBpbiB0aGUgbmV4dCB2ZXJzaW9uIG9mIHRoZSBwYXRjaA0KDQo+
ID4gKw0KPiA+ICtlbnVtIGF0aDEya19odGNfY29ubl9zdmNfc3RhdHVzIHsNCj4gPiArICAgICBB
VEgxMktfSFRDX0NPTk5fU1ZDX1NUQVRVU19TVUNDRVNTICAgICAgPSAwLA0KPiA+ICsgICAgIEFU
SDEyS19IVENfQ09OTl9TVkNfU1RBVFVTX05PVF9GT1VORCAgICA9IDEsDQo+ID4gKyAgICAgQVRI
MTJLX0hUQ19DT05OX1NWQ19TVEFUVVNfRkFJTEVEICAgICAgID0gMiwNCj4gPiArICAgICBBVEgx
MktfSFRDX0NPTk5fU1ZDX1NUQVRVU19OT19SRVNPVVJDRVMgPSAzLA0KPiA+ICsgICAgIEFUSDEy
S19IVENfQ09OTl9TVkNfU1RBVFVTX05PX01PUkVfRVAgICA9IDQNCj4gPiArfTsNCj4gPiArDQo+
ID4gK3N0cnVjdCBhdGgxMmtfaHRjX3JlYWR5IHsNCj4gPiArICAgICBfX2xlMzIgaWRfY3JlZGl0
X2NvdW50Ow0KPiA+ICsgICAgIF9fbGUzMiBzaXplX2VwOw0KPiA+ICt9IF9fcGFja2VkOw0KPiA+
ICsNCj4gPiArc3RydWN0IGF0aDEya19odGNfcmVhZHlfZXh0ZW5kZWQgew0KPiA+ICsgICAgIHN0
cnVjdCBhdGgxMmtfaHRjX3JlYWR5IGJhc2U7DQo+ID4gKyAgICAgX19sZTMyIHZlcl9idW5kbGU7
DQo+ID4gK30gX19wYWNrZWQ7DQo+ID4gKw0KPiA+ICtzdHJ1Y3QgYXRoMTJrX2h0Y19jb25uX3N2
YyB7DQo+ID4gKyAgICAgX19sZTMyIG1zZ19zdmNfaWQ7DQo+ID4gKyAgICAgX19sZTMyIGZsYWdz
X2xlbjsNCj4gPiArfSBfX3BhY2tlZDsNCj4gPiArDQo+ID4gK3N0cnVjdCBhdGgxMmtfaHRjX2Nv
bm5fc3ZjX3Jlc3Agew0KPiA+ICsgICAgIF9fbGUzMiBtc2dfc3ZjX2lkOw0KPiA+ICsgICAgIF9f
bGUzMiBmbGFnc19sZW47DQo+ID4gKyAgICAgX19sZTMyIHN2Y19tZXRhX3BhZDsNCj4gPiArfSBf
X3BhY2tlZDsNCj4gPiArDQo+ID4gK3N0cnVjdCBhdGgxMmtfaHRjX3NldHVwX2NvbXBsZXRlX2V4
dGVuZGVkIHsNCj4gPiArICAgICBfX2xlMzIgbXNnX2lkOw0KPiANCj4gaXMgdGhlcmUgYSByZWFz
b24gdGhpcyBpc24ndCBtc2dfc3ZjX2lkIHRvIGJlIGNvbnNpc3RlbnQgd2l0aCB0aGUgb3RoZXIg
aHRjDQo+IG1lc3NhZ2VzPw0KPiANCg0KWWVzLCBpdHMgZGlmZmVyZW50Lg0KDQo+IG9yIGV2ZW4g
aGF2ZSBldmVyeSBodGMgbXNnIGJlZ2luIHdpdGggYSBzdHJ1Y3QgYXRoMTJrX2h0Y19tc2cgaGRy
Pw0KPiANCj4gcGVyaGFwcyBhbHNvIGNvbnNpZGVyIHNvbWUgbmFtaW5nIGNvbnZlbnRpb25zIHNp
bWlsYXIgdG8gd2hhdCB3ZXJlDQo+IGFkb3B0ZWQgZm9yIFdNST8NCj4gDQo+ID4gKyAgICAgX19s
ZTMyIGZsYWdzOw0KPiA+ICsgICAgIF9fbGUzMiBtYXhfbXNnc19wZXJfYnVuZGxlZF9yZWN2OyB9
IF9fcGFja2VkOw0KPiA+ICsNCj4gPiArc3RydWN0IGF0aDEya19odGNfbXNnIHsNCj4gPiArICAg
ICBfX2xlMzIgbXNnX3N2Y19pZDsNCj4gPiArICAgICBfX2xlMzIgZmxhZ3NfbGVuOw0KPiA+ICt9
IF9fcGFja2VkIF9fYWxpZ25lZCg0KTsNCj4gPiArDQo+ID4gK2VudW0gYXRoMTJrX2h0Y19yZWNv
cmRfaWQgew0KPiA+ICsgICAgIEFUSDEyS19IVENfUkVDT1JEX05VTEwgICAgPSAwLA0KPiA+ICsg
ICAgIEFUSDEyS19IVENfUkVDT1JEX0NSRURJVFMgPSAxDQo+ID4gK307DQo+ID4gKw0KPiA+ICtz
dHJ1Y3QgYXRoMTJrX2h0Y19yZWNvcmRfaGRyIHsNCj4gPiArICAgICB1OCBpZDsgLyogQGVudW0g
YXRoMTJrX2h0Y19yZWNvcmRfaWQgKi8NCj4gPiArICAgICB1OCBsZW47DQo+ID4gKyAgICAgdTgg
cGFkMDsNCj4gPiArICAgICB1OCBwYWQxOw0KPiA+ICt9IF9fcGFja2VkOw0KPiA+ICsNCj4gPiAr
c3RydWN0IGF0aDEya19odGNfY3JlZGl0X3JlcG9ydCB7DQo+ID4gKyAgICAgdTggZWlkOyAvKiBA
ZW51bSBhdGgxMmtfaHRjX2VwX2lkICovDQo+ID4gKyAgICAgdTggY3JlZGl0czsNCj4gPiArICAg
ICB1OCBwYWQwOw0KPiA+ICsgICAgIHU4IHBhZDE7DQo+ID4gK30gX19wYWNrZWQ7DQo+ID4gKw0K
PiA+ICtzdHJ1Y3QgYXRoMTJrX2h0Y19yZWNvcmQgew0KPiA+ICsgICAgIHN0cnVjdCBhdGgxMmtf
aHRjX3JlY29yZF9oZHIgaGRyOw0KPiA+ICsgICAgIHVuaW9uIHsNCj4gPiArICAgICAgICAgICAg
IHN0cnVjdCBhdGgxMmtfaHRjX2NyZWRpdF9yZXBvcnQgY3JlZGl0X3JlcG9ydFswXTsNCj4gPiAr
ICAgICAgICAgICAgIHU4IHBhdWxvYWRbMF07DQo+IA0KPiBzL3BhdWxvYWQvcGF5bG9hZC8/DQo+
IA0KDQpTdXJlIHdpbGwgYWRkcmVzcyB0aGlzIGNvbW1lbnQgaW4gdGhlIG5leHQgdmVyc2lvbiBv
ZiB0aGUgcGF0Y2gNCg0KPiBzL1swXS9bXS8gcGVyDQo+IDxodHRwczovL3d3dy5rZXJuZWwub3Jn
L2RvYy9odG1sL2xhdGVzdC9wcm9jZXNzL2RlcHJlY2F0ZWQuaHRtbCN6ZXJvLQ0KPiBsZW5ndGgt
YW5kLW9uZS1lbGVtZW50LWFycmF5cz4NCj4gDQo+ID4gKyAgICAgfTsNCj4gPiArfSBfX3BhY2tl
ZCBfX2FsaWduZWQoNCk7DQo+ID4gKw0KPiA+ICsvKiBub3RlOiB0aGUgdHJhaWxlciBvZmZzZXQg
aXMgZHluYW1pYyBkZXBlbmRpbmcNCj4gPiArICogb24gcGF5bG9hZCBsZW5ndGguIHRoaXMgaXMg
b25seSBhIHN0cnVjdCBsYXlvdXQgZHJhZnQgICovIHN0cnVjdA0KPiA+ICthdGgxMmtfaHRjX2Zy
YW1lIHsNCj4gPiArICAgICBzdHJ1Y3QgYXRoMTJrX2h0Y19oZHIgaGRyOw0KPiA+ICsgICAgIHVu
aW9uIHsNCj4gPiArICAgICAgICAgICAgIHN0cnVjdCBhdGgxMmtfaHRjX21zZyBtc2c7DQo+ID4g
KyAgICAgICAgICAgICB1OCBwYXlsb2FkWzBdOw0KPiANCj4gcy9bMF0vW10vDQo+IA0KPiA+ICsg
ICAgIH07DQo+ID4gKyAgICAgc3RydWN0IGF0aDEya19odGNfcmVjb3JkIHRyYWlsZXJbMF07DQo+
IA0KPiANCj4gcy9bMF0vW10vDQo+IA0KPiBidXQgdGhpcyBzdHJ1Y3QgbWFrZXMgbm8gc2Vuc2Uu
IHlvdSBjYW4ndCBoYXZlIGEgdmFyaWFibGUtbGVuZ3RoIHBheWxvYWQgdGhhdA0KPiBpc24ndCBh
dCB0aGUgZW5kIG9mIHRoZSBzdHJ1Y3QNCj4gDQo+IGlmIHRoaXMgaXMganVzdCBzdXBwb3NlZCB0
byBiZSBzb21lIHNvcnQgb2YgcHNldWRvLWRvY3VtZW50YXRpb24gdGhlbg0KPiBwZXJoYXBzIHB1
dCBpdCBpbiBhIGNvbW1lbnQgc28gdGhhdCB0aGUgY29tcGlsZXIgd29uJ3Qgc2VlIHRoaXM/DQo+
IA0KPiBvciBwZXJoYXBzIGV2ZW4gYmV0dGVyIGRyYXcgYW4gQVNDSUkgcmVwcmVzZW50YXRpb24/
DQoNClN1cmUgd2lsbCBhZGRyZXNzIHRoaXMgY29tbWVudCBpbiB0aGUgbmV4dCB2ZXJzaW9uIG9m
IHRoZSBwYXRjaA0KDQo+IA0KPiA+ICt9IF9fcGFja2VkIF9fYWxpZ25lZCg0KTsNCj4gDQo+IHJl
c3Qgc25pcHBlZA0KDQpUaGFua3MNCkthcnRoaWtleWFuDQo=
