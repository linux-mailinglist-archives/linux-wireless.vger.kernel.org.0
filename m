Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11155045BD
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Apr 2022 00:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbiDPW64 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 Apr 2022 18:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbiDPW6z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 Apr 2022 18:58:55 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-oln040092072029.outbound.protection.outlook.com [40.92.72.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3718140F1
        for <linux-wireless@vger.kernel.org>; Sat, 16 Apr 2022 15:56:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYrR05QGRdyPcLheSBYNPPCfjwGFNp9pOhahQdfP5uXDLIPULGfhvDHl/BxTa6Wu15yPld9g+0U/jjiGOqpNA9Vguuofb4gLapC2ZN3YO3bwO6/P/eSmxPonLxQmsy51KTLAkPPNB3FItJJgMUR6TPKdssiYBJQA8Sv4qA5BqMGMgNf1cqF/t9DrPZT5l4KivSphd4Lp1r4XgzwMcbV/c7sBJXrvW4b9uEOiLIjqYUL0ak/T9fhOkaSOmxMM289Z/9wUzgW+IYsddU0TPGPBpyhkqcVgvNbUPzS7a3+obJzUGKUsg0FgHRafluj5h7U0D81eYsyx6w9dt4ISA649QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWYyMnUjxJ3tDaKMy8BipMPTs7HZ1XdJRfE2TJ7XjEU=;
 b=mSKb0+s7obpq4K+DoOcIEagW/VnDc+2/YajVCeQ+Zx77mvielssWQFsFPMRVjyRv7VLERRAuFYqlFmLrctvYAnxHgOct6OnA/1gZDjQKzl7VIaJq46hkSeTay65ahnq3QXC/rBmI9HoJpVZrqJA1kNs39x4Ab3nF7swFh0vKOshCUSe2Lx3yfHwVBv6dhPCBUUmbCZtU3V7caLtf6GqPmIvsgWBp5cmkqTjVUKY4gs6TCQ3nRw+Ns1uv3o73BdauEdpQS7hb3FYuQ9M1r5vASpjm/nJS++IT54PbYM/VoBcVey3FMiq7T0Z6C4VfPvaJJUYunlCxKhcoO4r5BZ2dIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWYyMnUjxJ3tDaKMy8BipMPTs7HZ1XdJRfE2TJ7XjEU=;
 b=Z/SU0NEqz5Q1N3Myo8QLH/MNmKH2NvgmzcyrsRMO87Vok1YBzj6bGAgE6eG+4rJkkP8s2sEANJ37uy/8EGjPLRrW2CcDCRpZJlyzeVdggmaYSyo2iFVwIKDG8ygy30kBng4irz3j27sjXDZCElOsp7R9M2hXkw+c5Vxu9ukavSqiWykvmfVFlO10igJOXRt7Vcyyd50w6o72wW4d9yJn1vHb0h9hKn/pK7mRq8/0EXDv3e3PvRb9Uxg8dhdkMR6/aWxOJY8hh7c+5IHpdvdaN3ZmI/IRfeaS9MvHE+IEknc3uJ9Z+KJWry9J2MBFpjQNoGtONON6EsWZpKyQSkACtg==
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DB7PR04MB5241.eurprd04.prod.outlook.com (2603:10a6:10:1d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Sat, 16 Apr
 2022 22:56:19 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::d091:3c84:8885:69d3]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::d091:3c84:8885:69d3%5]) with mapi id 15.20.5164.020; Sat, 16 Apr 2022
 22:56:19 +0000
From:   =?iso-8859-1?Q?M=E1ty=E1s_Bene?= <notabenem@hotmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Intel Wireless 9560AC speed parity between Linux and Windows
Thread-Topic: Intel Wireless 9560AC speed parity between Linux and Windows
Thread-Index: AQHYUeTzWY8O1OUWjE+w6ZOY/RMBGA==
Date:   Sat, 16 Apr 2022 22:56:19 +0000
Message-ID: <PA4PR04MB936651D0287FD6B7EE6C4C29BAF19@PA4PR04MB9366.eurprd04.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 63b48ee5-99d5-6dbd-748c-5c17075ee969
x-tmn:  [BT8jXzF4nMDNQ4VBAMqIfCx30O57DGGg]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f9ce85e-5a58-4477-1ec6-08da1ffc51e7
x-ms-traffictypediagnostic: DB7PR04MB5241:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m/1AeIIBKJbHu1azvzAtONri+06XaqVTSDyQHZ5vFbhw/6OBAJy+ZmhcoNJWSAcrai+S/pAlK+aTSKUSj49QNCeglJqB0sKoVQkmDJZ+Mpq5PPhhlQ1O6N2Vg4maPgf7oxCF16QwLNCYY9MohhWxtIk/0YgMg/XgaJoCo1UnQPlsGwOESZDdYA6/Y2CuNoEc2kYaKRVZ1Pp5rFWAN34RYW7vqOIupHODpw3c1rGDvP6XdaQ4PMoMftB0oILhjO2p0aeomNddMW5on9rzIEBReZHdDySn+L7/TVk8dXM5bgikeWiCQTKW/qxkn95fNXIyg9M/Xqiwf5gDh6hX5MJCEtkDR7KZ87y9B1fswcUmTZnB/UxBPxb+u5b/75QJa5EandpjO9ZNdvnXbAk2YPMEVkgMVImV3rEHMtedBbrFn3Tmarx52euuOpsbovHNNtHZ6M8QeyRCVxO3SkfZ7rBbJb64ARCxnPJ+aqmZHXrM1ruemBeZWsnu09ncT7njx7AxuncpFKzk5PEfOYun0bZ4L1aTtWfAOsMsVxoZ5+LVL7ipbo6U45/l5cUkkfd6ZF8iZWwBhps/CVUQrsW+hUgknA==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TD4CAjw47WiHVz+GFPja6isfD9dfir8s/wFXmzks7MjFz2NImygjm3sEAQ?=
 =?iso-8859-1?Q?UEWsKl8vj12KuA3NrXTr5YakcT8nm1o/XmrHCYJqzZ/gMCtTQXzBmtA+Op?=
 =?iso-8859-1?Q?IbpgJGpdLgzCUbwcjXACn4tsUJklQOQ+lH+Wr/Ralw2Fi/HEkTfM3avxbT?=
 =?iso-8859-1?Q?1eEjmivhNOrfLbK9gXChwbiHDf4rPaCtHMPQuWkrZFyWsTUolV4aeX34mI?=
 =?iso-8859-1?Q?H8FUGk0+TO/h4j9+9gvF23iHOKf0lpsgCRRFNScqbq00KdD/MCKuwDX0uh?=
 =?iso-8859-1?Q?wRhD0Wlzy3Jf2IT6XSAE2q6j1QQgA9eci7IqLU6/c/rB5oXhozmm3fJlZY?=
 =?iso-8859-1?Q?xHrbcZlf+3mrQoTdbCI4gSmX9H5qN4lLtnHgW/q6sYOPI7Z8EQX+gCuJvf?=
 =?iso-8859-1?Q?4pVp47xhKTw+B2kXeQkobQN0FA3RNqscw7bnJLhItLVtM1X79+Bohsz+3g?=
 =?iso-8859-1?Q?OVc2qU+chEOJfu+9PnBD5CLdZNIiPtGw36OKLbVK+PEvtBFLnz+ufJ7ibo?=
 =?iso-8859-1?Q?ZUwe6Q23A2F4EO5FtHQqXx5UrsM0dO6MyFaOJ2kxUQTbAucM3Tu/vh2AuA?=
 =?iso-8859-1?Q?2IufPX/WaGfF12WRKJ/t0Z3De8zC8eF+57fEVga5P8oO/sEnK7DSDA3BWF?=
 =?iso-8859-1?Q?aKXYZspeBV5roe2C4K2MYGD0o2ECIh1c8Wr+4Kxg7dDcgQ3PMfKPCkQnRc?=
 =?iso-8859-1?Q?DuAabDkNDIBrzxorVZ35mhxS4JsskdCiNepxBO0kPoSofwkHe0OoxkXHye?=
 =?iso-8859-1?Q?Cg3DDIQGrrVZTXeZJGfGhJKpgKUvdrL2so5gI3jw8g6s5ZvccN23dLhbot?=
 =?iso-8859-1?Q?wrWM5W/ZUX/GPBNtEjrCAcPSr6rYO5IfR6LNteb79/fOlcpzkDqPZHy0gA?=
 =?iso-8859-1?Q?oJ2zmaIU5tWPrhK4cvzhv4A/d85Jrn9mR+ZwaO1u8waKlrgA2ST1EHsAcq?=
 =?iso-8859-1?Q?cFg4kmx0JFXjfOvRTtot4AYuPtgMxamUF7JDsC/QJZFAPBkYTdy2rbnQpp?=
 =?iso-8859-1?Q?O9tguwxhL50Aea1JWBACLTeyhQ0Bl8tuk/GKKwKWwc9K5D2n9YjUl49i6p?=
 =?iso-8859-1?Q?M+7wWN3kmd27clxsMfTQEkg+U3UC/0na5GjjwWTi5y9fzGi8jtaMoVgFCb?=
 =?iso-8859-1?Q?mMHmQjte6RzRgheF9onEWUz4+9iwDgZma9Bdo+KWO5FNQVqIGRrflOqf3V?=
 =?iso-8859-1?Q?RsvpnYC8iI1W9dboAqtuJhit+7Z6eg923XSG5E3h+xOvlbkEFgYfE8Xf6M?=
 =?iso-8859-1?Q?3A+8BT+r55Fik2vBxiV+jt+Df0VXpFEamL1OTDalcZHv7dicH/qnp9Ooc6?=
 =?iso-8859-1?Q?oe8uuCxEIj/HXI77nGaybcQ1Xa3G2BWfbjB9D8+uM4O8c+h7PALsvK+lxl?=
 =?iso-8859-1?Q?FdngEfgdtMz44PQSRZGSRbb4UC+au2v7Lo4hEHwZhzg+X1DeNw/Kc8us2m?=
 =?iso-8859-1?Q?pbZG4ev/0UTQe/SOc2BiFMRMI8omH80OnvxnEDCK3Z4re+HgCyAb53JFKA?=
 =?iso-8859-1?Q?Q=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-03a34.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9ce85e-5a58-4477-1ec6-08da1ffc51e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2022 22:56:19.1729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5241
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dear devs,=0A=
=0A=
I am looking for some performance tuning tips to achieve speed parity with =
my Intel Wireless 9560AC wifi card connected to an 5Ghz AC network in a Len=
ovo X1E Gen 1, between Windows (achieving approx. 24MBytes/sec download fro=
m my NAS) and Linux (18.5MBytes/sec download) running kernel 5.17.1.=0A=
=0A=
The access point (and NAS at the same time) is a 3x3 Asus RT-AC68u router (=
supporting only 80Mhz bands, not 160Mhz, unlike the card itself)=0A=
=0A=
So far the best settings I could find for=A0/etc/modprobe.d/iwlwifi.conf:=
=A0=0A=
=0A=
options iwlwifi 11n_disable=3D8 power_save=3D0=0A=
options iwlmvm power_scheme=3D1=A0 =A0 =A0 =A0# this does not seem to have =
any effect.=0A=
=0A=
However, this is still ~6MBytes/sec slower throughput than when booting Win=
dows on the same laptop. Other than the OS/driver on the laptop, everything=
 is the same (the downloaded file, the position of the laptop, etc).=0A=
I'd appreciate any advice you can provide to reach the same wireless speeds=
 under linux as in windows.=0A=
Thanks.=0A=
Regards,=0A=
M.=0A=
