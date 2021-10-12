Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF097429EA6
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Oct 2021 09:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbhJLHcd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Oct 2021 03:32:33 -0400
Received: from mail-eopbgr130080.outbound.protection.outlook.com ([40.107.13.80]:32674
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233650AbhJLHca (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Oct 2021 03:32:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXGD0ipQFPSOXrQ28M8l3IkcKhHu2+YYdqWxbIRfayUZp3t+i4sQVXDSJF3i+vNNZ7tFssIvu9lcoUTgw4lYokZIuTJOs3C+mDmIFwxldMr0uP9ak6V6thvNvyLtDrFaQUczZarJbOrWh0APBjMamEH2NAI0TCYRKAHaie+Z43sl0ovxrSNrWbSPAsEtoYZN9t6sEML4nK5K1EIXxqSZg/06Ko8/gD8PvD4D7zsXYz1GDd/HwDKiHnYHuAYlpxamZH2JXfqtJQeBrheIbne1AotCIlfNG4R5ipBkzR4Rnh1twP4BgCkZgjnmz7RRFAbj37iE8QjOilaY85s5GevSMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1pR8kFn0FqVXJNXy7GAc6GNi1ZSEC4iIzw1KkX1cz4=;
 b=epg8NwNDap46at5JpkiFG/N8HdTeGLcJQUg8ZXdmeSlczgphMSLNueeDaQ8AJoB4CoqaB6CpVTkAzYWUSNrCGdyHxJS1Y+duhxSRg0kCLwhWfHO9UswtZtJeR/qPtoTpNikU7+FprCfauASfeMxYjHi6FHwduVmD7tuJUp4oz12MklEEtJmDCTHrm0L9yOR76wIQvEyewVo/Ccr2E6HjeFKqsWvOVUAcvAwkZOucKCGmErItXQeBd8KGQMEzSxVniNifrvzoTZcVbK0+8FFdXWbrOlpHhUIXcDq0iMVSlWPTPM6LkSS2sWw9SPgj+m3bqsWrHn3mjNNAKkjaUVtzeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1pR8kFn0FqVXJNXy7GAc6GNi1ZSEC4iIzw1KkX1cz4=;
 b=SkDhwk1WfXHo2kEFpA1Kewu/3QC5Ob1R7ozwf5vjMDa/5yAqm958EdDhNfgaM7REgZE1OJwl8zNLEWt60g4YrIaR6+UmmJ49moP2jiVMGhmBdlkpTC5KDLeYrLG3ySdAsJSwrtYU53jpH4mpHQ4lP1oZtQAKOdIPJLBdj0bM1/Y=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=westermo.com;
Received: from AM9P192MB1379.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3a7::21)
 by AM9P192MB1061.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Tue, 12 Oct
 2021 07:30:26 +0000
Received: from AM9P192MB1379.EURP192.PROD.OUTLOOK.COM
 ([fe80::e180:d6f5:b80c:42fd]) by AM9P192MB1379.EURP192.PROD.OUTLOOK.COM
 ([fe80::e180:d6f5:b80c:42fd%9]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 07:30:26 +0000
To:     =?UTF-8?B?TcOhdGjDqSBLb3Bww6FueQ==?= <mathekoppany@gmail.com>
References: <CALOm-MsEcY7=MwfoEzhCQqSUM6qANy=oP5xYmoPqHAaADcscwA@mail.gmail.com>
From:   Matthias May <matthias.may@westermo.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: ath9k: unable to connect to hidden SSID on DFS channel
Message-ID: <1c9e0038-d40d-40a0-ac70-5bfcc8d8b95d@westermo.com>
Date:   Tue, 12 Oct 2021 09:30:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <CALOm-MsEcY7=MwfoEzhCQqSUM6qANy=oP5xYmoPqHAaADcscwA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FAetPlTvIWh3OtUTOqXiH0YNzNatNJS9C"
X-ClientProxiedBy: HE1PR0701CA0086.eurprd07.prod.outlook.com
 (2603:10a6:3:64::30) To AM9P192MB1379.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:3a7::21)
MIME-Version: 1.0
Received: from [172.29.101.174] (46.140.151.10) by HE1PR0701CA0086.eurprd07.prod.outlook.com (2603:10a6:3:64::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.4 via Frontend Transport; Tue, 12 Oct 2021 07:30:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c82d0883-d50f-4d64-b8dc-08d98d5228c1
X-MS-TrafficTypeDiagnostic: AM9P192MB1061:
X-Microsoft-Antispam-PRVS: <AM9P192MB10618B1A525A75E51CD96344F1B69@AM9P192MB1061.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ueNGEVcZ16NhcgbTtcxjdnFtc3Zl/tmgcL1t8SlHGy4HTqg0qINqPa3o/WOsPFGA5dCGBSU58k9QpBKNKJ5BsUISS1cLnqvJhLmZqDjpKRq9wGMIgnJ79Dw8sJFO+A02kezXDR1acF/N2pBmTazEhm/h5KwBolmMzioFG2MRMQHL6k4Q7KGgd7TpsbZKNoYeE81ECzju4TokSTW85qj4PoUd+S6CTMznZ5Xwh65xGieo2sVN65VTkfG41o7UtmnzKH2jAfuaCunmCBWSW5fT3fY6z3nno/jYLH2D1na8FlClJxNrzWUYa+2Cq/Rm1D6hemMSlTM1AjfdAh22lMLZf/lswWWhva1t8CkjpPmFSCTEBRCp3A1UYj4ct8HbnDHXqw/AkzQuMN2KS2MUhcaPwq/39w8BN67COM6G3xhvj9o9gj+mXrbT+ffvIR5QLgZTDMp58ghBb7H9OFcgO+ICa9eRFdHONFj1ZfPnObJBCusXblqc3RBYaMwNOxG+ixKNKMymloM9BG17pN4O9Fo3DOoMnyjEPUVmLerlGoQq4sDJ2iPnrVsibXeubnsVut/GRWUPrAvbdhAxcMT7YmC+yFQpfpZ0OHKNH4uvhSdXMX2+HZ6o1LNfnBa/Ti6tlwV50yJwAsqhxWgTqiZL2q88q+zo+4cgHZRhgCpaDsQ9TZrcHhsNpzI6lGrvoV6QZ/o6XcMAis8YAHpoLiCF1NQKCMFUTZRt5HfwbhADoyy+xIeea9RkSnQlZiNJR7YJXzepwrCbKHf7Z9zNkvw1z5+/9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1379.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(31696002)(4326008)(83380400001)(8936002)(36756003)(53546011)(66556008)(956004)(52116002)(2616005)(508600001)(66476007)(66946007)(33964004)(21480400003)(2906002)(26005)(6916009)(316002)(8676002)(38350700002)(235185007)(31686004)(6486002)(16576012)(44832011)(186003)(5660300002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2F5NDA0R2ZFamt3cmc3UWNaNGdjT2VWaUZZWWNHenNPalBlZzNpT1JiL3hr?=
 =?utf-8?B?MlJWRnV5YlhIWmRGaDh1NlpVYVVxU2dVQ0c4V0FQZW53OFlmZHJVaUZ2eGFT?=
 =?utf-8?B?SlU4MHIyRHRQMEFLWWR0YVpXL3hXbGxDdVBLK2k2dXVYYWhSaDZhSFQrREEy?=
 =?utf-8?B?SWhQdDVaWUZiVVdIblRmZ05XalhMN3RmUGtzaXEzdGtUamIzQTF0b29pa2Fr?=
 =?utf-8?B?RDgxb3RFbDFFWFdCZDlkaVJ2c1pwdWhWTmtnREVuamJjZE9lbk56dWR1QWVL?=
 =?utf-8?B?c3E1c3pUL2dzU1RPL3RhMHBaVGJySDlwby9kOEtYRjAyY29hTE1PQnI1SVZy?=
 =?utf-8?B?Z296ZDBaYmQ5ZHYxa3M0WGY0RkxSaEtXempMeDZIZ2pkLzZ2ZWtxVU1ZbzNu?=
 =?utf-8?B?eUU4cWlWSlg3c2k0a1k3VkdzUStIZjFkRVhxeTFJem9kR0Q4SDRrQTlwVWNp?=
 =?utf-8?B?ODg0Ny96SDF1ZjhDQW9rVzgxZURBZFRFQnZMY1BSeVd1aTJXSFEzb21wa2xz?=
 =?utf-8?B?UFIzY1B2K0hzSXlzdEg5WWVIMmZzU29uNGlsR25jcWpaaEZIZDVkMTJZZWND?=
 =?utf-8?B?NjV0U3ozY3VSTUhIYjNJOHFYem5SQlVjS3BYTklDTi8rMlZtN3lseHdkM2lF?=
 =?utf-8?B?b3RqVnh5SFJaT0NMUTlBalpUd3MrWTlkWG1IMm11ejNPdWhGSDVsSE15NFVQ?=
 =?utf-8?B?Y2k5c01meW9zakpscWo5Y0t1UXlsMndGc2VZOVNtWks1QXNBNUcvY21jd1lH?=
 =?utf-8?B?ZjJyUUhiQ25NWm1kSkFTaGIySlZTUkQ2V1FYTHZrVUZuL0d5WnZPdGdlOFdF?=
 =?utf-8?B?b25ML0t1Y1hSSS9Pak8xNTF2ZTlsOGhYamtWR1Q3eVM0ellERGVkSk55R1F2?=
 =?utf-8?B?ZFZDMC9nakZ2bXlKa1JGdlNCL1RTYTFlS1BxZE5EcEIxVjdsY2s5NngrcU95?=
 =?utf-8?B?S0svNU5UTUVHNDZ6eXFFY0xIKy9jMzF5ei93OGZtQ0tIWnN1K2pvbnBaMG1u?=
 =?utf-8?B?SThSOUJ5WkhvL1Bza0FKWTVQUi9xNURNemE3OFN5UG5NL3VUSFl6MEEvWUJC?=
 =?utf-8?B?Vk14eExlVTREdmVSM2hsTlJVK3dkZlhOdHFCVXZJd2M0SHNTNllrVTBxSkRh?=
 =?utf-8?B?NWpEN1VETFR5TlRBZldtYUxIYmRsbCtzZGVFeThjbEc5b2ZjN3htOGhwMUhx?=
 =?utf-8?B?clBNRzlOMDgyMDBWT1h0MFdaNis2Q3hSUExxTndaZ1ZhRDBMN21BS29jYlVv?=
 =?utf-8?B?ZGNoOXJxQjJYeWlTbXdSNExFa3ZBdW9zcm1BYU9RMHFwNzNjQXJTR0dqZEs0?=
 =?utf-8?B?bHV1Wm1rMHd3Z1V1aEpWYW54UXRuRmFEQWJYUU5iaWhQS0FHcUFQcnhISEN4?=
 =?utf-8?B?b0ZBKzJtaG91MDI2bWNEakdXR0dsa2Q4NkhrZ3pDOEI0MUMyMXdxS09BRW14?=
 =?utf-8?B?L2xZVDJuczROREU0NjVrUitzM2duQTAvbE1Jdk51c1RjRm5ITXJ6bmluVDhK?=
 =?utf-8?B?VkNacG5HbHp2S0RPWStGYUtkaXlGN2xmT29JbXBKTElCdjExNlJrUlUzbXFa?=
 =?utf-8?B?bmR5a0c1WWw0WXl3aDI5UEw1Ry94b3o1MUlkaEVvMWNSSkpIdGRaSGl2bzJU?=
 =?utf-8?B?Mlhtb2xvZkt5cTg2d0htcE11ZW1FMk94eURzeVFjdFFReGZRNjNwVHpuMCtk?=
 =?utf-8?B?VncrM3lEaTQ5L2RDREF3L1RCZ2RLeG1DZEVoTENHVVZPNGJFU0N3NHVpMlYx?=
 =?utf-8?Q?BXhJqe0zyNLAVnP4W1uN7dVVpMSEC4uCyXH1/k2?=
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c82d0883-d50f-4d64-b8dc-08d98d5228c1
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1379.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 07:30:26.1360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C9tesCE/gF0glSCNARuUTab6RlJxLhFmQql4ubmd2aMZEwguIj3hIzr01/hOaq6bZJ9S+lDCNfNss+x5ykEVkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1061
X-MS-Exchange-CrossPremises-AuthSource: AM9P192MB1379.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 06
X-MS-Exchange-CrossPremises-Mapi-Admin-Submission: 
X-MS-Exchange-CrossPremises-MessageSource: StoreDriver
X-MS-Exchange-CrossPremises-BCC: 
X-MS-Exchange-CrossPremises-OriginalClientIPAddress: 46.140.151.10
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-Antispam-ScanContext: DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-Processed-By-Journaling: Journal Agent
X-OrganizationHeadersPreserved: AM9P192MB1061.EURP192.PROD.OUTLOOK.COM
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--FAetPlTvIWh3OtUTOqXiH0YNzNatNJS9C
Content-Type: multipart/mixed; boundary="P9vIujYLKtROrZ7xtw3I3D5QM9SUTNKTt";
 protected-headers="v1"
From: Matthias May <matthias.may@westermo.com>
To: =?UTF-8?B?TcOhdGjDqSBLb3Bww6FueQ==?= <mathekoppany@gmail.com>
Cc: linux-wireless@vger.kernel.org
Message-ID: <1c9e0038-d40d-40a0-ac70-5bfcc8d8b95d@westermo.com>
Subject: Re: ath9k: unable to connect to hidden SSID on DFS channel
References: <CALOm-MsEcY7=MwfoEzhCQqSUM6qANy=oP5xYmoPqHAaADcscwA@mail.gmail.com>
In-Reply-To: <CALOm-MsEcY7=MwfoEzhCQqSUM6qANy=oP5xYmoPqHAaADcscwA@mail.gmail.com>

--P9vIujYLKtROrZ7xtw3I3D5QM9SUTNKTt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10/11/21 12:46 PM, M=C3=A1th=C3=A9 Kopp=C3=A1ny wrote:
> Hello,
>=20
> I have a project where I want to establish Wi-Fi connection to a
> hidden SSID, on DFS channel.
>=20
> I am running wpa_supplicant 2.9 on a device with:
> "Linux 4.9.51-yocto-standard armv7l" and
> "Network controller: Qualcomm Atheros AR958x 802.11abgn Wireless
> Network Adapter (rev 01)"
>=20
> Sounds an old project, I know, but want to bring this alive, if
> possible. Unfortunately, connection to a hidden SSID on DFS channel
> seems not working.
>=20
> However, it works on a different, newer device, which has
> "Linux raspberrypi 5.10.17-v7l+ armv7l" and
> "PCI bridge: Broadcom Limited Device 2711 (rev 10)".
>=20
> The wpa_supplicant on the two devices is mostly idem: same v2.9, same
> runtime configuration, almost all config variables (wpa_cli dump)
> match (not seen relevant difference). There might be compile option
> difference, but don't think they are relevant.
> The only thing I see is with driver flags, where the newer device
> supports flags like DFS_OFFLOAD, BSS_SELECTION, or
> 4WWAY_HANDSHAKE_PSK, but the older device does not offer these.
>=20
> So I suspect the issue is due to some of the above missing features in
> my ath9k driver (have default driver provided by kernel).
>=20
> Questions:
> - is it possible to enable the above driver flags/features for ath9k?
> If so, how to enable and are there patches for these?
> - any hint where to look in ath9k driver for passive scanning
> implementation? Is there another module/location where passive
> scanning is implemented?
> - any suggestions for a solution to my issue?
>=20
> Thanks,
> Koppany
>=20

Hi

Clients not being able to find hidden APs on DFS frequencies is not a bug=
, but by design.

Facts:
* When enabling hidden SSID on an AP, the SSID is not sent in the beacons=
=2E
* Clients (non-master devices) are not allowed to transmit on a DFS frequ=
ency unless an AP (master device) tells them it
is ok.

This means that a client can find new APs only by scanning passively.
Since the beacons do not contain the SSID, the client will never find the=
 AP it is looking for.

Some ways around:
* Your client is a master and does radar detection (with all its downside=
s), thus it is allowed to probe actively
* You hack your beacons and add a custom SSID which allows the client to =
get the SSID passively (hack both sides)
* Your device behaves illegal and sends probe requests on DFS frequencies=

* ???

BR
Matthias


--P9vIujYLKtROrZ7xtw3I3D5QM9SUTNKTt--

--FAetPlTvIWh3OtUTOqXiH0YNzNatNJS9C
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQR34wKNh4Jxr+4dJ/3fdrYEUzwNvgUCYWU5kAUDAAAAAAAKCRDfdrYEUzwNvtHr
AQC+F4Z0ccz1Qj2f6ir1WV1uzbIyk+JveMncUkQy2iOCHAD/X4/2ArxTbfVYRML+jlZfY9UF8msN
KA8Jm6iVgoUeIwI=
=U177
-----END PGP SIGNATURE-----

--FAetPlTvIWh3OtUTOqXiH0YNzNatNJS9C--
