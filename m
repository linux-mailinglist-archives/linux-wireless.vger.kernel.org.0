Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0524B2BE2
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Feb 2022 18:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352214AbiBKRhY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Feb 2022 12:37:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245333AbiBKRhT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Feb 2022 12:37:19 -0500
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.142.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975A2391
        for <linux-wireless@vger.kernel.org>; Fri, 11 Feb 2022 09:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1644601038; x=1645205838;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9kcvh2GjNTm4BmBnBPbKM0ElLdwD8zhIiTYUSMZfgms=;
  b=1oINLGNnqbMTG1eG+ThNWldvlmd2dAEEqz0IN7RzXt7/p/U4e3PmuMIP
   SEzL3JtvnRES/WKSMfVTihxBWvKwJN+l/I9Bru7MklA34hUhYhFoWTaVx
   WeAuyGX/CUQLLwZVzsb+0LsmB+uN0bgNJ6qZZ5ciHx6IagSNPuS4qTed0
   E=;
Received: from mail-mw2nam08lp2170.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.170])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 17:37:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzq4X6lgRKLNE6b4v6tthpvxbzoGbyLhrf6im9Es81dwJawjxgmSrKE8EunDF13oH+bkGDFb7k74h9vubNL6h9FEzf6ztd303kyx1JgUQ2a78GUIVT/ZRpZtejypQR8To6b9YVG90F71gZk84Wwqe9WRuOMegUuWQov1aT4Z6asT9wwHjX3kWurC34RLG69/BuBTDcImk/+CLtYHPld0/Eg+wod0k4FvLdV1EtjMDk8Du2/xTfyc33QdPWCvtagduwvmahCye/UgI2vd8cfn1dFgdMjFutkkvWNlRDX/wlDzvoLWdhbWZxUa4mBj2/qJ2KBlKjyvvJpwotWjX10+pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kcvh2GjNTm4BmBnBPbKM0ElLdwD8zhIiTYUSMZfgms=;
 b=i70AElYE3ZOHRsCOHSxwF4Tz4+KP6VBkOFVtDCjLnD/yBKgF5TkVrwOT+o2H+2+luhejb0rr9dbYGEeWjBbCsT/KO9T7r4w5BrM4P5F+v36OqKmMPVkE5ZW1dOqDm23wxG08ojWs21IyqlAVLSoTCtQQEhRo27ZZGyijsOXMYpxvP+jQW5QYY0SFhBZS8hmEBkXYS+ID8OfJbkUVStwsOLHOQW/r7WDb6GiPcdhPspJjLqFLOoFW3YK2ordz+sPnxIRMyskSukRbVdNKBU2uv87DNCs+SOlHsdNA1DtiUYn7Tn+VghlzFELDguA+wtoeG1oOR7hNqyS+ZMwL1eMcDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DM8PR02MB7958.namprd02.prod.outlook.com (2603:10b6:8:13::19) by
 DM6PR02MB5163.namprd02.prod.outlook.com (2603:10b6:5:46::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.17; Fri, 11 Feb 2022 17:37:13 +0000
Received: from DM8PR02MB7958.namprd02.prod.outlook.com
 ([fe80::3419:bf67:4f7d:7ab9]) by DM8PR02MB7958.namprd02.prod.outlook.com
 ([fe80::3419:bf67:4f7d:7ab9%4]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 17:37:13 +0000
From:   "Aloka Dixit (QUIC)" <quic_alokad@quicinc.com>
To:     'Johannes Berg' <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "Vikram Kandukuri (QUIC)" <quic_vikram@quicinc.com>,
        "Aloka Dixit (QUIC)" <quic_alokad@quicinc.com>,
        "Jia Ding (QUIC)" <quic_jiad@quicinc.com>,
        "Karthikeyan Periyasamy (QUIC)" <quic_periyasa@quicinc.com>,
        "Muna Sinada (QUIC)" <quic_msinada@quicinc.com>,
        "Sriram R (QUIC)" <quic_srirrama@quicinc.com>,
        "ilan.peer@intel.com" <ilan.peer@intel.com>
Subject: RE: [PATCH v2 06/19] cfg80211: Add data structures to capture EHT
 capabilities
Thread-Topic: [PATCH v2 06/19] cfg80211: Add data structures to capture EHT
 capabilities
Thread-Index: AQHYHrNJZcplRJTMmUmfY0kLbEi9TayOnbpQ
Date:   Fri, 11 Feb 2022 17:37:13 +0000
Message-ID: <DM8PR02MB7958C66988E52F40F0ED8A6AFE309@DM8PR02MB7958.namprd02.prod.outlook.com>
References: <20220210192008.188166-1-johannes@sipsolutions.net>
 <20220210201853.c40044dc90e9.I2413a37c8f7d2d6d638038a3d95360a3fce0114d@changeid>
In-Reply-To: <20220210201853.c40044dc90e9.I2413a37c8f7d2d6d638038a3d95360a3fce0114d@changeid>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fef6aabc-6d23-4ab4-1f91-08d9ed8523c7
x-ms-traffictypediagnostic: DM6PR02MB5163:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR02MB5163AAB2BCBF7DFB0C54498882309@DM6PR02MB5163.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8c3QSzahZ3e9588hotgAf1eAMrcW8njX5uxMEZKHHS0y5R0R0D4cTssi1eaJbdGbDVouJIe9U+CDovncTbPme+5bZ/OInmbM2BAGt1feDYgfrK7tsgDWSJPODooLnAxpLqck1DNmuHYSb2GpxQ++5XzUQbP+QHMtukpwUBzM8c7X3Q36JCIiB6LG2N4GFpfw7bME5r56sklRA0zaQ0EJlsvJ8hHLkWySZo3BuTpU1Pgc4cXNw+2vCPDfPkd+vvQg8qdsS/wrM8TMQcS8xp1kS9v1EdNhNicnr/0h0KgQOh5s5cFyb3zuH+tbi0zdtEuT1CUqlYLChbK2mXKFLcsGZVWRRCE8pweAePmu2UWMM3V7x3xqudcbqLoGN/UCkqEmklCwBVkkU76/8rCZnqWKv6tMTmuZ5Hg5nIl5BIuxhhxIqKRLFtHD/8Gd/eIsuunb9SltoQmVXrRi/mA0T2Z3MjyE/vwNI1zAe6hglkdP8Rfb4xvSgZr4X4gMBvL6Y90/dMB0sdfFNvGgBnwAI5HwZJH9l3oVuTu0/HP8y09A2kZN0nI2IVN3XqloYB82F/BzdWKcUoUKMw3nEJpUcIXz4AQn08Bo37T7L7uXJ/GUlmNCn9kaLcH2NU4N9Pg8xJCnZYbTyez8OPIgsZ06Qgs2D5slib02pfVc4h1JpTVkhAXrsdV6BRF1gDdiTRD3oW70ebxUj0GshhKK4pZxPRjmUg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR02MB7958.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(4744005)(38100700002)(38070700005)(5660300002)(186003)(52536014)(26005)(8936002)(55016003)(316002)(33656002)(66946007)(71200400001)(66556008)(76116006)(4326008)(8676002)(66446008)(64756008)(66476007)(7696005)(2906002)(122000001)(54906003)(508600001)(6506007)(110136005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1UeaeqXAdUilFyC9KWDnVNH8481I9ryDsepAgPTHPHbT2hfYjmCSJG6Eb9uy?=
 =?us-ascii?Q?bs3N2oF7CZYxYu8IGMhmQ9XgApu3RY5HqrFmFg2HAoufHmuKTg1UOhm/rxGy?=
 =?us-ascii?Q?TU84bj63lGdVpfns7urYEgdPkKX/V+gsc48JGvHR/Wgz24fQs8JAq+U8N5mc?=
 =?us-ascii?Q?JmsLpbx8SupJdpvesir6oxoua7BOSCcf/FC3tfTdHeK21SUjL4w8fg1lqCiO?=
 =?us-ascii?Q?39CplG0I0jYaiHbjA+/ZAtPPKDtVg5BNJdqBOOGwmcMR+SB7r9USVhP4u9sn?=
 =?us-ascii?Q?MNCdUg8FQghSV06VgaHsqjULwVumzB7hnJCQYdFR0H1oT1y6hgrJ41O/VQzQ?=
 =?us-ascii?Q?XfhYXpLnESrYKg60ObOk+gntVoGMTthirrq94k4U1LOHfRXKRdtmuo9zyJO8?=
 =?us-ascii?Q?fi+Pw61ECMdJ4WpyWymMRbExX7B+hXyfu1bSdYtah0/aVmGQ+k5N1+OHFzgo?=
 =?us-ascii?Q?HGH4ZOk3qO3Q/bHONPUbkNbIwzPwQFU1rB6dQmujfDhpyQ7leVE80zpGchn1?=
 =?us-ascii?Q?ABWLDyofSSyHQw9oykUKxIR0vZgGTxdegAbSUByfLTtXr2Y5UP2tI+u57aM6?=
 =?us-ascii?Q?+38FXc5eHJ936eEzRuoQfiTlAOfTIt3cJ7aEsWbmoJRY7yjxpz4+1JJEQMdd?=
 =?us-ascii?Q?FM07OcT4+XGqjfh2HtRiF7vfaL51fwbvQYUyYDdLfCV8gZdDkbwEX8SG8LNk?=
 =?us-ascii?Q?s/p+kemNaTUUlePFrd8sXxNMrh2X+i8Ue2YXshs2iyRvbARk2GF830GJTwub?=
 =?us-ascii?Q?vXPcBCK9PPO18Ky57O3F9gLst6g3N+GCfweGPSMUW6YPH33yiXR2GdeKu+c7?=
 =?us-ascii?Q?UZjgV5J+C6WTTMFCFH7/6T3OLH8B/pUZ8VInqvg6Vb9uQiK5hxIx70Lanve7?=
 =?us-ascii?Q?n2/t6p/KfGXflwxUW0k1MdygcSYQWb0w/YhCvLdnpaiGk0CIkoab8Eu+avKw?=
 =?us-ascii?Q?YSl+EJrpxJ/ozx1cLKkXJxwpxoCFxqmG7dRs+PGV5/9mxj3slLoXCC7sfm1g?=
 =?us-ascii?Q?t8IO5PIrz1TpYdwm/W/cO29hwGaesOjc31W+PPkEA6+eny/LAL1nIL5g8Giq?=
 =?us-ascii?Q?HMrYm1+shhrQxRJlvP9B6EBS8R8a8harGj3Fxi5p/X36aXISOgPzWr25Cv7z?=
 =?us-ascii?Q?OIK4sr4j3W5DBlmQoctZc9/3BdrlXJ+W2h/xI6qExY3LM7BThirXMbvxqoGO?=
 =?us-ascii?Q?mKoSpql64bnCXatdhNOLUsFAYfT0kGu7qd8SC2ERLweFXH6M4ER72o6kXjbY?=
 =?us-ascii?Q?HnRZdKpdnAKe6VSsFPxgvJD537EJ3Nwb9nn+8m/42tr4iDYDDbK8mT9NKikj?=
 =?us-ascii?Q?jgEllsYU3BI86zJVi8itHfVFoVeyTmHroBb0zpfDLziwMEBGHJ54xSzuAEOL?=
 =?us-ascii?Q?kdf88ZEMs7ic5yBfyXGzEyrEsiAAMXEKGNagmCtsOpSNZbwMJq7BchhzgSGU?=
 =?us-ascii?Q?+jtcK9D3o9EvYH/J8pRjRvRV0HNL6lD9Wz1mw+N+U+MXyaMF7GsR9RqwIAwR?=
 =?us-ascii?Q?l0zCQXOoA8gNgMkYzWynwe61bMAu64itdCLcLlt8ABTEKghofXKrn1JQf5N5?=
 =?us-ascii?Q?yBwdPsd3hX75hKc1DGSyxE+Xvc9aXZ73wxqlI8RqOJcbxEjG0+09YDL2lF+l?=
 =?us-ascii?Q?OA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB7958.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fef6aabc-6d23-4ab4-1f91-08d9ed8523c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 17:37:13.5384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V+cvqSPQJ5A8hyxo5t1apZseNwONNQn6F831UQkL2JsYz7an7YeAmlLl0J3fZT+QE0zWJ/cUefuZAK2TAQHMQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5163
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

And advertise EHT capabilities to user space when supported.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h       | 63 ++++++++++++++++++++++++++++++++++++
 include/uapi/linux/nl80211.h | 12 +++++++
 net/wireless/nl80211.c       | 27 ++++++++++++++++
 3 files changed, 102 insertions(+)

Hi,
An instance of struct ieee80211_eht_cap_elem should be added in struct cfg8=
0211_ap_settings (same goes for operation element) as well and parsing in n=
l80211_calculate_ap_params().
