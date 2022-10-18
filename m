Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBF860354B
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Oct 2022 23:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJRVzh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Oct 2022 17:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiJRVzf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Oct 2022 17:55:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D2A7FE63
        for <linux-wireless@vger.kernel.org>; Tue, 18 Oct 2022 14:55:34 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29ILbM7t017423;
        Tue, 18 Oct 2022 21:55:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=VzsySnXVYmP6w124VrcJyamK1wKPsHwu6/C+6pABY0I=;
 b=EHn8nCiCQs6KXs2erbR6Q3QidQkYu+9bE7grjfoeS72/HqOeuNYexnWnesnU9oEpm1sS
 bT+hyHlUJ2TTGdwBzGgQEgMjUZ5JPdfXpzHLV6kD0Y+mgAc9wDTyE/E7wQfIOiHfJNEb
 4ZNfLwb4X8UkM3v5FYz5wrZnL5xfws0tEPNpQa+jYLnlE8P88E+tcMPJoW1JVKy8jw14
 TeQb5RV2CjrXQfEWRVWUX9ewZ5rTIB6msHPYtXZDY4k3ARxNHudGxOBE84kHTnYNZi6Y
 ZQ+fl5PR2psnEEXmwj7PtZXGC5dKWxtYWTG0l9GRrRSJZ5uVUMJ+HOQ6+OxB5ITM1lLx Uw== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k9bfg4ccb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 21:55:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQ9X6b6yIQ7WdnzfftoNHE9BRze7DDGhpQs+R/gpNFl230c5RIwY7c7ahdyasE97MC8bkw5GtlRSFr/PzdGrW1NCrfpN90KTC0sU8BSDzuAhlrQ5jZhnKY+7xGMcs5ltAJg4ztbuBihNa9JLW+y4cR4YJXHmu7wWQkYeCtS18kSD+ovlbt42DFgrgb9P2oyltMsdUucxeYoL7Ulq+fe8Sg8NCO5BVbB6WRWDXMoY7Pqt6XscKOgQUeDApN82rrW4/TVJddL3k5vLtL1AUOmI0bEkEfuI4LkoMlPRdFLMVTWBXS/lsFY/6SWA7654S9expgq93dwFdF9DluYqmCFudg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VzsySnXVYmP6w124VrcJyamK1wKPsHwu6/C+6pABY0I=;
 b=cB84zLqP3d1dHe0OaDQHshKvA4Qk8khGpOqe6j9nwJwMElHgrQqUH6cpiLAhMn8o1Xjdx4Xp04c5bIxUW0aobGJde25AJ5VCmHT+KoE0D5UwzBW6YOFm+vpWF2YVrQWQbMWI/SRMxGDgAjzVNnkdtZStt2W7klIp3xqiFe6RxqcMyUSKhlbi6ee0tuqASeeCEgU/US7f4dTR/86pzZ6DxrzOsJEojBALMLeSwDr4VpgyJMFyydLELDDZUoRTKghJyIVv8bMTfBUeHJPPeXldYAyJKOxkfi3A58b+ioe5uYwWCLXFkSPvsH11Awp5tqo+1NiG8none/jn+bssuuteNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from BY5PR02MB6164.namprd02.prod.outlook.com (2603:10b6:a03:1b0::23)
 by PH0PR02MB8534.namprd02.prod.outlook.com (2603:10b6:510:10d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Tue, 18 Oct
 2022 21:55:27 +0000
Received: from BY5PR02MB6164.namprd02.prod.outlook.com
 ([fe80::b677:f24f:c0ea:c42]) by BY5PR02MB6164.namprd02.prod.outlook.com
 ([fe80::b677:f24f:c0ea:c42%5]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 21:55:26 +0000
From:   "Muna Sinada (QUIC)" <quic_msinada@quicinc.com>
To:     Kalle Valo <kvalo@kernel.org>,
        "Muna Sinada (QUIC)" <quic_msinada@quicinc.com>
CC:     "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 1/4] wifi: ath11k: modify accessor macros to match index
 size
Thread-Topic: [PATCH 1/4] wifi: ath11k: modify accessor macros to match index
 size
Thread-Index: AQHY3mmbP6Nh+RQOUEiyJUXSjzn4CK4MUqGAgAhnBZA=
Date:   Tue, 18 Oct 2022 21:55:26 +0000
Message-ID: <BY5PR02MB6164064B7069CE45A34DBAC28F289@BY5PR02MB6164.namprd02.prod.outlook.com>
References: <1665599807-12908-2-git-send-email-quic_msinada@quicinc.com>
 <166564252533.7747.3943450152611127759.kvalo@kernel.org>
In-Reply-To: <166564252533.7747.3943450152611127759.kvalo@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR02MB6164:EE_|PH0PR02MB8534:EE_
x-ms-office365-filtering-correlation-id: e44e88f6-6074-4a9b-d818-08dab153774c
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ls24xFy9Dmey8lBi1xUvWW0vVNCC5GpP50aRj1sIHnXbIxkHb2+h08aMqvFrfSFbcyBmhKPA9vb5IL0/vuV8d7VE3vQtYLakEGZjoDCH6gOFIHu76ygKdhkFkaK21O+L25wlLxlaQemjwHy4uPjOfnI3utTW0tVK8cVQocrrZessAxtKsSkdKFBXwYrJWmY5zZsI3ydZr0TXdWYYr2R2dROqNiZCNVw+F4SToTVyNuq+9p/VYHhNQxi6lHx0Mct0ZYK48No+c7SvCUyD0cgcgbFHBuDzCrrZnz00jidRjJSVi4sehB7n0tSItYInmxYcsX3MbwNAk3ouSNbxO84aRWN2O89pk76DQ52YAR8TgXLM/gszMrwUj/ZX3kzi2xipVzbsmOTJOWnYiv56M0ZxHEi9LEO8vBiYM0krjRTubx7n/llPPhOfWXNnFYuTrVq4/z+4U7JIxVh9vJqgW4kjDF3iM42rj2wk5ITD3wOO2WUasqmmhNKulw+H4PB5OdrkJ3HycTsirmKRaqozdqBtneuzIeyUDPCcB3d37twUSuDu7UcAzWo5xBq2RVkd6vsfciHGBhSIuzpbkvCKtpZX5WF+7WxKnCZg9Bt6oPZjRnMWRfrm7zyDQ5D2gc0hOp9AKR/4TJCfzCcvw0PmbS2pBu/o5UL0OoE2pTGqQG9p1JnFfKm58KektEim1suT7nJBnL9z4U7X0dWXz+KKkxiLkIUnaDimXf47BhPuacdAvTEa3ZDEQ5rorOqKq75hSrbouYIH0umGhYfDtLReSXRvRlFq/0bF7OMPU4iybfDdXFQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6164.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(451199015)(966005)(478600001)(71200400001)(38100700002)(8936002)(52536014)(110136005)(9686003)(316002)(54906003)(41300700001)(186003)(26005)(122000001)(7696005)(6506007)(4326008)(55016003)(38070700005)(5660300002)(33656002)(64756008)(2906002)(66476007)(66556008)(66946007)(66446008)(8676002)(86362001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekgzZUdJbnJKa3NRcnZjSTI0MlIyRlNhSHQyeE9sWXI1S1RPM3liOW9oU0tu?=
 =?utf-8?B?MENKRUJDNnpWR2VZR1djZVc1Z3hjYVBIdHdlaG5WU1gybHgyN1VuZ3Z4WEkx?=
 =?utf-8?B?NkpBbHZvdkZ3RGRmQWFGUjluMGViMXBWVFY0RlpzWEZTVFNoV202UndWK29Q?=
 =?utf-8?B?VDV6ajRicXE1T05QZnl3V2haMWIwSFNPYjN6bEtZdGlhcndDY2hoR1FTUVI0?=
 =?utf-8?B?cnRwbVJld2VyeW5tQzR3T1h2L3FRa3N5c1o1OW1lVmtzNWtKbkJrMDdVdU9t?=
 =?utf-8?B?MWFQajA5U1Q1enRVUm52RzUwdDZ4TzlHNGRCbGc2UmlPdmZsVTBudGdDelJk?=
 =?utf-8?B?TUROWWdwSHNxa3lvUjluMVovcncyNlNIODYyQkM1VWk0dTNmNUloZXAranJF?=
 =?utf-8?B?U3MzR2tPaSs3UmRBZXNmVENjSnJaazVoOU5iaTJzRVdQdHpWSmVQNTIrRlVQ?=
 =?utf-8?B?b2hOLzF0QTVwdWxrK0xFbFJIQUF4RjE2UDdCdTVrZmNMSC9aOUJydStWYVFP?=
 =?utf-8?B?UkcrWFdoT2ZVL1loQjVEakZveUY1Q0VBZHZHb2hiL1g1UzNIMVozSzVzSmFM?=
 =?utf-8?B?TkxjZWd4SnpNL1VINThza3ZaQVVJcnRYY0VQakd1VDJhTjU5SDZJdzYxbTdN?=
 =?utf-8?B?cFN5bHRkb2FlV294RzBBK1JKdWloSU9LRWNRZ0RhcG92YlFWamdhVWlDWG1F?=
 =?utf-8?B?eUR6Nlo0cTJkWC9LRFk3YzhCM3VsajU4eWtlT2dHYy85QUI3cGVLYnV5c2ht?=
 =?utf-8?B?VCsvWmpEZVhOM2NGTC9ua0RnOGU2ZjJzQmJZNUU5aDFQSHZlbEpSU2c2WjZJ?=
 =?utf-8?B?anppbGpZTm1LRjdxTTNLMUNFNldOS2hvbkhhOGc3MVpsbU1DZnlKUTZFSjlq?=
 =?utf-8?B?MWU5NFU1RFRBTUlpREtOVGFJMktKYVlYUW9kUThoRUVWQTEydS9MQnBza2Zi?=
 =?utf-8?B?Uk1KaWxLQ2xUOHhYVm5QRWV5MCtxcEFyQkQxQjFCMlN2bVU0bXIzRDBzZGVu?=
 =?utf-8?B?U0lOV0xWa3pKcGtjVlI0R1pqUjlaOFVnekd0bVE4cVBrWkc2UGxLWmovWm1s?=
 =?utf-8?B?UGFSb0lpbFFFelNpQ3A1dXpxeVdEVWlwN3JEM2t6NFN1SVdiU3RMaHU1c0Rz?=
 =?utf-8?B?K3dScHd4WDV6SXA1S3h5TXRIcjBIZzRyNzNXS2F5SUVId1RJYXU4bHdlZC9r?=
 =?utf-8?B?Zm10U3JUbmZORFVabFMzVjduVWVack5IZGFEWnZ2bGxUQ2playtDLys4a1pO?=
 =?utf-8?B?VHZvSGJRcUVIYWthQXd6WVhWb2puQW5mcFZScW9DSFBSNVdjSm1pQ205czJ1?=
 =?utf-8?B?amIzQlJrR2dLWWlmZlZadVFSLzF5a2srTkszT3VSRmVWVWhNZUpXendBeUtM?=
 =?utf-8?B?QzBtNzBZcjJNb0IxRjlKakNlcmVyWDFxUmdHcjJPOTI1OEF1ODMyVm94b3NQ?=
 =?utf-8?B?WlRlbVlzTkpHRVB6YUlVUFlSclpvTnNsbUJiK1l5NHBUNTg1b1hyTjJ6RkZh?=
 =?utf-8?B?RVJWalJVeFhsYjh2L3hnbVNtU2pUR1R1ZHk5bkM2YnNEUTgrbzRndzE0MG9k?=
 =?utf-8?B?OEE4T0F2emFLS2Z3dTZuZEJKUHpNR3hMT3pUaDZ4bURvbzdWQmhvdkhlNHJk?=
 =?utf-8?B?ckwrWGowTm91S1NYYXVUQ3NsTG8wdThHQTMzWVZSSUdWejlsM0hJc3hWMitB?=
 =?utf-8?B?aWEwZVdNR0R3SUVvZi8yL1FPRXFlbHpxSjJ1eFR3QjkzQThHTER5MEtNdTFh?=
 =?utf-8?B?Q3lSaEFRSjJIdE9UUFV3bHhWcUtHdWk4YXFGOEN0ZlRFNWcyWkU1V2VqQjhB?=
 =?utf-8?B?N2lteThxLzBXaG50M1FGOE1LWE9vNW9GbFlNQlA3TTZEMjVNR0Zid28yRktI?=
 =?utf-8?B?ajJCMVdQbDZLdzAyVnVld2daRmY0WE9HZVJlci9BcExBcmx1RnlkVkZXMzE5?=
 =?utf-8?B?SW1rR0QzR1R1ckNkTklLNTJFT1NNUG00eVdYeStPRGV4cGxkdVFBUXdGQldy?=
 =?utf-8?B?dEVST2VXajR2VE1yWTlFSzZOaExRU0d4Z1Jac3hVeVpIcDEyK1UwdE1TbG1s?=
 =?utf-8?B?bm5NZDE0cVAvZDJNN2VCMUNpZnFoR0hpZzFwSGMzZFpHbnZjcTdiR1VUUWh2?=
 =?utf-8?Q?cIOlhOuR4F72nM4aL1lpCicVO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6164.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e44e88f6-6074-4a9b-d818-08dab153774c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 21:55:26.7960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XpmMFvYi4Mqm2citVdl9PuAHV6WN1q4YP3tMIZOOQhaAkjYtDADghnrhYXjpw1jZ/JZ1BfRJkDIpAwEhzadzwEpOVF7mR09xFc2C86dQbg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8534
X-Proofpoint-ORIG-GUID: g0f63LTariuKlB7x08uv5GPSRK3di2ht
X-Proofpoint-GUID: g0f63LTariuKlB7x08uv5GPSRK3di2ht
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_07,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0
 mlxlogscore=774 mlxscore=0 bulkscore=0 spamscore=0 suspectscore=0
 clxscore=1011 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210180123
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

S2FsbGUgVmFsbyA8a3ZhbG9Aa2VybmVsLm9yZz4gd3JvdGU6DQoNCj4gIGRyaXZlcnMvbmV0L3dp
cmVsZXNzL2F0aC9hdGgxMWsvbWFjLmM6MjcxMTozMzogZXJyb3I6ICdzdHJ1Y3QgaWVlZTgwMjEx
X2Jzc19jb25mJyBoYXMgbm8gbWVtYmVyIG5hbWVkICdoZV9zdV9iZWFtZm9ybWVyJw0KPiAgIDI3
MTEgfCAgICAgICAgIGlmIChhcnZpZi0+dmlmLT5ic3NfY29uZi5oZV9zdV9iZWFtZm9ybWVyKSB7
DQo+ICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXg0KPiAgZHJpdmVy
cy9uZXQvd2lyZWxlc3MvYXRoL2F0aDExay9tYWMuYzoyNzEzOjQxOiBlcnJvcjogJ3N0cnVjdCBp
ZWVlODAyMTFfYnNzX2NvbmYnIGhhcyBubyBtZW1iZXIgbmFtZWQgJ2hlX211X2JlYW1mb3JtZXIn
DQo+ICAgMjcxMyB8ICAgICAgICAgICAgICAgICBpZiAoYXJ2aWYtPnZpZi0+YnNzX2NvbmYuaGVf
bXVfYmVhbWZvcm1lciAmJg0KPiAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgXg0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvYXRoL2F0aDExay9tYWMuYzoy
NzIyOjQxOiBlcnJvcjogJ3N0cnVjdCBpZWVlODAyMTFfYnNzX2NvbmYnIGhhcyBubyBtZW1iZXIg
bmFtZWQgJ2hlX2Z1bGxfdWxfbXVtaW1vJw0KPiAgIDI3MjIgfCAgICAgICAgICAgICAgICAgaWYg
KGFydmlmLT52aWYtPmJzc19jb25mLmhlX2Z1bGxfdWxfbXVtaW1vKQ0KPiAgICAgICAgfCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXg0KPiAgZHJpdmVycy9uZXQvd2ly
ZWxlc3MvYXRoL2F0aDExay9tYWMuYzoyNzI1OjQxOiBlcnJvcjogJ3N0cnVjdCBpZWVlODAyMTFf
YnNzX2NvbmYnIGhhcyBubyBtZW1iZXIgbmFtZWQgJ2hlX3N1X2JlYW1mb3JtZWUnDQo+ICAgMjcy
NSB8ICAgICAgICAgICAgICAgICBpZiAoYXJ2aWYtPnZpZi0+YnNzX2NvbmYuaGVfc3VfYmVhbWZv
cm1lZSkNCiA+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IF4NCg0KDQpUaGVzZSBhdHRyaWJ1dGVzIGFyZSBkZWZpbmVkIGFzIHBhcnQgb2YgdGhpcyBtYWM4
MDIxMSBwYXRjaHNldCB3aGljaCBpcyBpbiBwdWJsaWMgcmV2aWV3IDogDQpodHRwczovL3BhdGNo
d29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtd2lyZWxlc3MvbGlzdC8/c2VyaWVzPTY4MzMy
MiZzdGF0ZT0lMkEmYXJjaGl2ZT1ib3RoDQoNCkkgaGF2ZSBpbmNsdWRlZCB0aGlzIGRlcGVuZGVu
Y3kgaW4gdGhlIGNvdmVyIGxldHRlciBvZiBWMiBvZiB0aGlzIHBhdGNoc2V0Lg0KDQpUaGFuayB5
b3UsDQpNdW5hDQoNCg==
