Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7245B6D2E66
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Apr 2023 07:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbjDAFdc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 1 Apr 2023 01:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjDAFdb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 1 Apr 2023 01:33:31 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2084.outbound.protection.outlook.com [40.92.45.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE37C1DF87
        for <linux-wireless@vger.kernel.org>; Fri, 31 Mar 2023 22:33:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AOeO+8INQ3VoNawHDk74Um/Jnw8hiS/EtpdMv7itvW6vkUO0B5uhHo19JCHZMvAaPobeDDLMK7u5O3Dtu2Gn2xR+U57Hrhn5sDwIO9Hxkqt/s/tZdpZx1vC3Fqkvh1RVopr9fNm6FEykIyGzfznObj4ulPLHod92P3k46SnFiGWtfx0moVExuqW0AK7W1VROvo/0EJpslMzwTV48zI1pX+SR+lSKFiPkqy3n8KsU2BMBvfPw3f5VKVVgy3Z9qQ5Dxy/mJp7gj0/he/J9Egt+lSuZXAw0VUBYTOhm5KMHkEK1HXdAhHFAMae188oD+a451mkJRdVLy271qerewj3zdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31LyEhtw+FlBwF0afwQghMzuGKy1irpWiKxhi8lfCbE=;
 b=Kz+WQ65lcXSwv3CwW29cQJfBUtbghYXZo4U8QlSV9E7tyT0Z6+WW+yhL3fe5mQXzz1s30iFusKYVHq7roX+i0LAp/LXOGHwK8KnaNM74FwVujpyIj58zqPrawtyG3px6Qf49C+DjftBmDF+YQyI82jsbaJqI4uZpJIJ4Z+i1F52uUo2Xs8ieUJPVJF+xQNXFp908Wgpvnd8lhnpIjj1sJK0H1ciktnokUzo1DVL9DDO+3Vvm/TE3x8d5Jt+tkJ8TY8LFG+rPvbp+otq95rFh0FxAfIBDxn6Sqm3CUsu2cW0R621bhH32n/diaS0EIt86WEAUkQ7PFU1GNocfXcW8RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31LyEhtw+FlBwF0afwQghMzuGKy1irpWiKxhi8lfCbE=;
 b=SWWWnDKNo9khA0NEfEjeilQAOcufZWL0VZoko6A3Z+zHMyyCwZaXLxlondEC4jlgxMqg8OTEyZj8XaiUvynALXpOsZWM5hv9+bicBPqqzQYHITE3eBPAFs6cH9fCmA4/MQJa7Ic11IlasjFt7MlaPH+/aWCl3jqnq+TFAm9AHyn3l+K79V0lG6+WWNQ37OnI1aOixPFvHbswEAdmpztSwhGTi+P7MDEJmBilQrhthnTthyzOdW8+3skbc396QZHL0k2XuZTuH0N7HUo7pacjvgeomAJ3HyB09Ml4AdCarBrQ4w4rEiSCDb1n4hZdgxGQOdV6iUIdda0f5CooKgxl/g==
Received: from SJ0PR22MB2495.namprd22.prod.outlook.com (2603:10b6:a03:328::13)
 by SJ2PR22MB4235.namprd22.prod.outlook.com (2603:10b6:a03:549::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.24; Sat, 1 Apr
 2023 05:33:25 +0000
Received: from SJ0PR22MB2495.namprd22.prod.outlook.com
 ([fe80::f3de:f07b:7676:239]) by SJ0PR22MB2495.namprd22.prod.outlook.com
 ([fe80::f3de:f07b:7676:239%8]) with mapi id 15.20.6254.026; Sat, 1 Apr 2023
 05:33:25 +0000
From:   Eric Sellman <gak_action@live.com>
To:     "sforshee@kernel.org" <sforshee@kernel.org>
CC:     "wireless-regdb@lists.infradead.org" 
        <wireless-regdb@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: wireless-regdb: Update regulatory rules for canada on 5GHz
Thread-Topic: wireless-regdb: Update regulatory rules for canada on 5GHz
Thread-Index: AQHZZD4WXRyFZKmuLUmT9dLETqAkMq8V1h0O
Date:   Sat, 1 Apr 2023 05:33:25 +0000
Message-ID: <SJ0PR22MB24952C980D15D984F0CEB61E8F8C9@SJ0PR22MB2495.namprd22.prod.outlook.com>
References: <SJ0PR22MB2495707E5FC7EF2334A699BC8F8C9@SJ0PR22MB2495.namprd22.prod.outlook.com>
In-Reply-To: <SJ0PR22MB2495707E5FC7EF2334A699BC8F8C9@SJ0PR22MB2495.namprd22.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [GfmCzVqGxgDfgDwxRatdaf/Ts/tWW3xidu5zcqko17s=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR22MB2495:EE_|SJ2PR22MB4235:EE_
x-ms-office365-filtering-correlation-id: b40a03f7-b5cf-4730-f99f-08db32729da3
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KnrZK3aS78BdZMtIOKxrln019zF9uABcm/P2GkrjJ4vmONG02atotByyqO1Q6kWrjsyA+UQ5ZLPQy+vB205iDw1YLhlEnoYQX3LJZDNmD0OTJSuSLxZ6RxBMQGwX7vK7Jk+io7BZ0L7FGPBGFLcsaMdbtJubgFmvdT/ib5rorZqFgJMGyVQn3F2UQWBPQxj0ZyoYJM/3Qthqw4HTh+nsmIkHXZzpQ5oWpwthLKVrMpPRPcT+6bDlpESX/Ui4TWvCapDI4p2qawxDoy2gU+nskbRgqb5Zjb8C6JTQjmf6QAgXH2bE3j4UG+aYcIe70WiwwpwP2hDnQhdR/0LSLj8kIq/MLeEfj7dzHfGGd5x7WrPxr/8o7wRc1K9kOHQFaR5thTpyBmu9SBu1z97QdvI9RPgmfkHpPoB30zRzNpVy1APdn7XgtWhLc5kfJs2WfvF2NHfOcrF+2Pe/qVeUy9UrCd4NMYSCI05V21lLkt4Zsc+D0MqyJNXR1mHfBIfrkam4XuUF+hMfPoqPmm3xHH0iHX30wRWpkDyEhf4V7qOJp31gf0lD5ZMhLKp3+ZYMJP7g3PrxMqZkKAeB5B+4YN+O/Q==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/hk+ObOI6ZaXproX5I+D5hIalrUkRt1G2SAkA5nlFbRNNiAwAmaysgGqmD?=
 =?iso-8859-1?Q?BfKMQemgnsXd5oBwV8Mv8VZG5jiVQh0ZtsFWBQYiA8YfpHyqzYoULphk+4?=
 =?iso-8859-1?Q?yUl60ZC4sLH2pAk1fNtf+f1jzmDDRuj5q/+gR7MV794GE/72yWzoNR6jrn?=
 =?iso-8859-1?Q?uZZaJfmG+JD18xkZhnn25Jj57NMNuvRX9P+XdvoNG+9Y3noPMiHEh975Uf?=
 =?iso-8859-1?Q?KDd68CUdnY3/wn7QpWe79mN8J9O1GzPvMnn6V5uoY9oCmZmr1d6PC/1O/t?=
 =?iso-8859-1?Q?85poJzjRrpogOjxQABGbPYZkAGqB7qGrGUqxIAqbkqJshEpQBtU5ELmtuc?=
 =?iso-8859-1?Q?Xlz7iCxb/M0Qttdi5P6meK9N/+yoyQxFqEF3qkCk87CnqJDio7qth7VZ4f?=
 =?iso-8859-1?Q?YEzLr/pfeWn5F9QRGr3YHSdRmFGtT+cTO7ZqJDepOAytKiOUc0NGl//xB8?=
 =?iso-8859-1?Q?LQCQHM3Flc37XagYibl2jB+Yk6Vlyy4hoAlRIKHRjjzNL76ybqg5hmL4BX?=
 =?iso-8859-1?Q?ns9+Fp2//at/8y4hWgK2cfHs0dGAWRCEyyAj3d6pG8ElKa1GwfPW2nKydD?=
 =?iso-8859-1?Q?qFa2i9H6cW8TbDuH7Rjw8+zaosr28gGwv8MONCnieWSuVF6D4NLSB8YlKt?=
 =?iso-8859-1?Q?pKgHT+5bIk5Mojts5AirDyrTWPgsLVRGDuG6W3JaYVGwCmKePOy9yQGBZN?=
 =?iso-8859-1?Q?HG8AO1+j96I0b7yuizjAQOMJLaVR8ITi4JS/1QiU9GeqHR/zvb+sMN2Ek8?=
 =?iso-8859-1?Q?9aKtw27bKrf7+k5Ti06h+9L8wqcKiuiddminDAliKSeW0wkopc1KrPsueE?=
 =?iso-8859-1?Q?YcfOEr20MiXxFuB1+IJxUVQunER6wZbSZjaPMwkcGa6zc78Zl3aCuYsxUp?=
 =?iso-8859-1?Q?xHqodQ85s4j86aX+UtLECM2yEzU0gDm9osF9XnA3ydcem/iLe1Qzh+UKcO?=
 =?iso-8859-1?Q?yu+sWkwpTUuAr445/1Dl3XvyRDGXF1z1SgwAxr916EaaMypVfkXKeWC9f2?=
 =?iso-8859-1?Q?WlXZLBOyvNjTazGr8M/w+sWspzfLplDqUMcqZ7+Undaxzyd+2QLx+xDJSE?=
 =?iso-8859-1?Q?KCHz31SuIRS7a0BLze9r4eNNJlRh/90FINIllhg8feThGheG2ArYKb5ePe?=
 =?iso-8859-1?Q?mc0o17UbSrPB7CllHaB7Ab5fbSfOx92B6FVtPwBk1ZxieHc+ehz+Xfmc2T?=
 =?iso-8859-1?Q?m8C/lONymEcPNakBcNOsF99WsOsUg7BpPsMAEpr+vahENqLrBHCp/HA2Ez?=
 =?iso-8859-1?Q?nJ/0mEjPFVQkudb48yng=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-c3c87.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR22MB2495.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b40a03f7-b5cf-4730-f99f-08db32729da3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2023 05:33:25.5425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR22MB4235
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

My apologies but I have made a mistake.=0A=
=0A=
My previous submission about Canada is invalid. The weather frequency range=
 has already been avoided.=0A=
=0A=
Here is the correct information I meant to share with you.=0A=
=0A=
https://www.ic.gc.ca/eic/site/smt-gst.nsf/eng/sf10971.html#s6=0A=
=0A=
"Devices with occupied bandwidths which overlap different bands shall compl=
y with all operational requirements for each band."=0A=
=0A=
https://semfionetworks.com/blog/5ghz-regulations-in-canada-2018-update/=0A=
=0A=
Canada still permits the lower 5ghz frequencies to be used for VHT 160. But=
 it's missing according to the information for the Canadian profile in line=
 326=0A=
=0A=
https://git.kernel.org/pub/scm/linux/kernel/git/sforshee/wireless-regdb.git=
/tree/db.txt#n326.=0A=
=0A=
And I wanted to mention that for 5150 - 5250 on line 328, the transmit powe=
r has been increased to 1 watt or "30 dBm" according to this document here.=
=0A=
=0A=
https://www.ic.gc.ca/eic/site/smt-gst.nsf/eng/sf11294.html=
