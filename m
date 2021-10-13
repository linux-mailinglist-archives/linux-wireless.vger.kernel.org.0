Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011DA42CB20
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Oct 2021 22:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhJMUfG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Oct 2021 16:35:06 -0400
Received: from mail-db8eur05on2047.outbound.protection.outlook.com ([40.107.20.47]:11776
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229839AbhJMUfF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Oct 2021 16:35:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/FRedLm4CcUEZ6u5Z1KttTIAbCLjtWdQUqUlCLHLezB3AvZ6IOy9BpTmqX7DDUlRuJl49C3TSxW17f+Nh7IKtJPEOEK3dOvX18KJGb81WnLq9m8JXAdF0+CaRVitrVLCX0n5A//IZiyGtGPN61EoFIPaZT7F53D7jGNWv886BNTMFuO7tINf5XsOzlig7QDSlXZViIZvv8FtRsEwW2F2CWLXVOiZcUbaSP16OuZyr61whmg5zlhdkRtRSiwDtjIS6HS7UgVQqKQH2J75h5emDjB68idu/vMJiPSHRNuF6zsw0Sd25ZPmgilkPPCovMN5VV8b/NRG2Nxu6jLp22YEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frfN27HXCkTMwWGlqBe9m3EorKykfAPfSil9gAserYk=;
 b=go1fZ0j1OvYAeDzelN7wcaq6PMHquBPFXXASUqxd4NUGFhy0+nS6jEwv41QYFzAYeQMauYaIVTBexQEkDLjuI0EotJCES5zc/gH/7B34owjN8rJGUsg1upCaqWM5HcwwkySBVoZn7TZB3CIstUheZF0CmtjChyucJhIAYdtUHuu8CZolA6tTI6Hc/1qVhZP77i9NOuH3iQ521PxUO+rLWjoccwYHFD3X93VPpI2pETIteldyKjjsZVSCxcycLdAlEwD5ZpXyUDv/0WoqO77M3/DGeDp8DDq7Nb9C5mxs/E7YIVJpIbko0DhIGm400rDlVFrwFeHo6N0pr6+GpOy9VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frfN27HXCkTMwWGlqBe9m3EorKykfAPfSil9gAserYk=;
 b=TeUmORFdzDC+8z8HrjT6QrRlpMGhV243u5icokfnTojuYUHVv9AkNNyn3ckG7mjSLlU//IgENpoGxkyZeDEL0Kb505eixO0nnadvWJyE9tB78QSMH04CXNAVtDtKUrp6S792dukzB6xnAzgQhC1E82oCdagPTJE2UV0QRcyLwT4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=westermo.com;
Received: from PAXP192MB1390.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:1a4::9)
 by PR3P192MB0554.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Wed, 13 Oct
 2021 20:33:00 +0000
Received: from PAXP192MB1390.EURP192.PROD.OUTLOOK.COM
 ([fe80::f879:ed8:39dd:f2d9]) by PAXP192MB1390.EURP192.PROD.OUTLOOK.COM
 ([fe80::f879:ed8:39dd:f2d9%4]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 20:32:59 +0000
To:     =?UTF-8?B?TcOhdGjDqSBLb3Bww6FueQ==?= <mathekoppany@gmail.com>
Cc:     linux-wireless@vger.kernel.org
References: <CALOm-MsEcY7=MwfoEzhCQqSUM6qANy=oP5xYmoPqHAaADcscwA@mail.gmail.com>
 <1c9e0038-d40d-40a0-ac70-5bfcc8d8b95d@westermo.com>
 <CALOm-Mug=Js5HUhpdJH_djDjPm9u-x-6dYrNMCOLP5gaRBYQZA@mail.gmail.com>
From:   Matthias May <matthias.may@westermo.com>
Subject: Re: ath9k: unable to connect to hidden SSID on DFS channel
Message-ID: <8e6549da-1ea0-c5c4-3b09-7cbfde76f5ad@westermo.com>
Date:   Wed, 13 Oct 2021 22:32:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <CALOm-Mug=Js5HUhpdJH_djDjPm9u-x-6dYrNMCOLP5gaRBYQZA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8MJhscVP9zYeEr9F0a5o4xHjd2GMoHMMT"
X-ClientProxiedBy: HE1PR0501CA0030.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::40) To PAXP192MB1390.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:1a4::9)
MIME-Version: 1.0
Received: from [10.0.11.180] (178.38.90.75) by HE1PR0501CA0030.eurprd05.prod.outlook.com (2603:10a6:3:1a::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.26 via Frontend Transport; Wed, 13 Oct 2021 20:32:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 300c5814-e4d5-4fd4-8465-08d98e88a591
X-MS-TrafficTypeDiagnostic: PR3P192MB0554:
X-Microsoft-Antispam-PRVS: <PR3P192MB0554C6AD4AB8F7C5710040F4F1B79@PR3P192MB0554.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DIsF+N1zQd5S/1v/+zDgtweuWCGpZf4u/saN+FKr4zBAXoU+Zo8PTUeTXe+2N5mWeOi28chMwMPYuoksjEwWUa7E5b2ClUGgp7xB1xqjrJuXSTLdpXD8Jq5Oui/jtHHYOB9JV71p5mlvkSrXPs4jyUjsTX6i84PmMN+saDpFfbz2T0iX86IvQ1A2sVe8q0nt7FuWK6xMmsvAcYRenTvOvJmqg9HFARNMSp35N9tXz18wmAE6u22CfW7khAXuQnHazIX9lkAgf7sEo+4/AnQNxepfrgZH/G78dcUu/yCo7mFKnXHQKQfJrpLAA1Q1B5t6i8TnaSeA1APeQpVb97F/9j1plSdQs8oEU9EBTgISma7sVn8FQxhPXpqEBFc4JX1Ze7jP/6YzTNGv0iLWlOSLmQVQjlCN99mJDByX41B7HaDglfYP6qiYwjPB8rQqBztGns08TsH0REwme4zfK7ndMlQl718QOlTBITfLN9GnPTUQSK2ykq0aepl/R4p0yHJwKb6LL0QxMxJ57KU1QvNY7Cq5D340K8bzYsl1Lwms5/9l7SepHyrqhoLd1d5KJMnALdvziXOBF4DwIOLNmUj6XggxJs3u+yhMmVRXJti6cas9N8ueNmBKWxEmlWLQinyfN7eopmsf69Csgx7I0GHN6moHCQk70majSLIUHnBs2mQlr64W/Y8mdQuhJpp8odEfeu6j+CmdZ4l+0WyBOIo9gTOqWscjAuYTe618YECPiacLAhMcxh1+qf58sZfu77xAY9DVSnamnQZfomjS4QBcNXm3FkjjZu4lSUydMLhApTLjDpW4dfLCW5Zv0hDytaSUEJUO9NLHKInQvC8wurDKNCrAw1k2x6o/swVQmTh/9+8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXP192MB1390.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(31686004)(956004)(5660300002)(186003)(4326008)(33964004)(66946007)(36756003)(66574015)(2616005)(235185007)(31696002)(44832011)(83380400001)(508600001)(966005)(38100700002)(38350700002)(316002)(53546011)(2906002)(52116002)(6666004)(66556008)(8676002)(8936002)(26005)(16576012)(6916009)(21480400003)(6486002)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFkza0t6UENwNUw4UzM1a2hhbzBYalRRVEpOaFY1MTFqS2F2U0JVcG5uNU1z?=
 =?utf-8?B?enMvTVFISlpEdW1YZmZqOVFqRit1Z0ZkY2N3YjFoTUJtVWFLTmYrNW9WZWxs?=
 =?utf-8?B?bDl3UDJGdUFoWEdBWm9mczRmT0ZnUVpUZ3ZDUExLV2dPMzdxZGViYlJ0MlR1?=
 =?utf-8?B?aisxUXdUUHJXTmRaZVplYjBZQWxrOTJ2d3hqZGI0QndSVjZFaS92dnF2SDNn?=
 =?utf-8?B?ZHVOc1V2TEpmRm51VTQ0a0Z3RThpSEhjeWNzUVBIeloySE5xMmRGSDRSbVFE?=
 =?utf-8?B?UDVXN0dUNkZHaVRKTHNuZlF6VFY3MFhReWQxenN3OHZReVVmZHpUcGFOQWRQ?=
 =?utf-8?B?cTNzVTlEN2ZFOUlzWm9OZWtCQ1Nlb0RSYjlvaVh1TXhOUXdxVVVwcVhyVTlj?=
 =?utf-8?B?UVZmL001VkwrNWFaVHdrZVdKMFExMFpJQlA1Y05PSEpsOU93ek5IbjdMQ0hu?=
 =?utf-8?B?aDBsTGNrVCtDK0dXamhsV0Y4dUFsd2txMkY0RjZvRnUvZ1Q4akVITTdDVFFE?=
 =?utf-8?B?UHcxbWlnblc3c2dlQmNtTGp1ay9kOGJEN2lvUlp5UVYvUVZsRVpIeFI0YUVa?=
 =?utf-8?B?VnBlcmYwOXhvejhlY2cvWG5qbk5GeUdpaEV6Wit5WEJzUTJLbHNMdC9ld3Zr?=
 =?utf-8?B?U29vSGdiMkFYbndwRXd0dTdrdnlLZ01xcitqWVN3WWlaU0Exc3pTZmx5QmRN?=
 =?utf-8?B?ai9QczAxTUFrMGlrbmhSdWZJcVlNUUs5dDZldlpTdFlDV0JrbTQzV0JSWWxj?=
 =?utf-8?B?Mjlvak85N0ZqZHJiZUdxZ3FKalVKSzJGc3dPVGlabDZQMUJ5cWtXMzgxcTZv?=
 =?utf-8?B?Z2xaRUFCalo4L3VpTmFRZ2UwUGY2TlNrMzNmaW9pNkFNd2NQdE5yZ05udVhU?=
 =?utf-8?B?eXQySmRwcUxSTzM4b2FYZnkwMlpqSWRqejhIb2FPUjlpT09UKy9WRjBLOTRh?=
 =?utf-8?B?akxpWUdPeWFvbnJtQzd0Q202VDlESjVCSS9aVHErRjV3SXhpak9hek11MEtS?=
 =?utf-8?B?bXJwUjRHMk5xbDg4dkxMVHRLdFA5L1dzYWFDU0EzSEgwVStEdGl3ZWc4V0pv?=
 =?utf-8?B?N2tHdStoRTVIZGFjdzFlTVpmVGl4cGQzSUhIWUZJdkEwc2YyaDBzZkFCWHNJ?=
 =?utf-8?B?U1Z6WmdLYXdDNnQ0Y0JZL3ZseW1VamF1TW8zaTNhYloyZ3puLytrYUVidEdj?=
 =?utf-8?B?WXZWVW1VVlBlSjVjdm5zMVpDQTF2c0UzNWE0dkRFdUV2QmVoZ2MvT2dnWEhE?=
 =?utf-8?B?U05LV0NXTnFBWHFOa1hVOSt6OWNPRDE3cVdXbHc2UWVFbFp1SkVvN25MNU1L?=
 =?utf-8?B?VXhYMzVyc3RzeGlPOEpreUw2ejN0N1VGeTk2V1oxOEYvWHZGWjZzY0tNMVFU?=
 =?utf-8?B?dko3cC8vUkpXSlpBK1plVGN0am1lVC9ib3NOT1lUdFpCdVV3bUN0bjhiQStD?=
 =?utf-8?B?T2l6YW1lRkFyQ2JFR2tiMjJEUEg4R2RSNnp6RlZOemJtTldUbmZNSjhnSEdt?=
 =?utf-8?B?SGV0Z1NYb3g5TzRSKzkrSnhGM01ubFJYenJxWDQwaU9HcklDcjc0dDBjWkh4?=
 =?utf-8?B?TitiVFJ5MEJEdi90YjJUTU8wRWNGRGl2TGhYZ0VuWkNVdGZldnhPTXkwMStu?=
 =?utf-8?B?dm91YlBtY0Z4a2hObWJUK3pNME1STnlCRlNYK3Y5UWFCUkFMcDVGNE9hV2ll?=
 =?utf-8?B?T29FZ09OTEJmUUkzMmtDNlVZYkdiTHo2SG9teTBVakw5QjE2VzRETDQ3bDNu?=
 =?utf-8?Q?qke4oiwsaLjGpjLmXjI+Y/S3OMwg4lloGAJ69IH?=
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 300c5814-e4d5-4fd4-8465-08d98e88a591
X-MS-Exchange-CrossTenant-AuthSource: PAXP192MB1390.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 20:32:59.5881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X8l47KNfAiZjPqeG/9kCOt4sqhZjgL/F5xZBgd0wbiEQ2hRqtZP4XrvwtVl2mMVyvgUFwQzAoLwgrKwjCjD3yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P192MB0554
X-MS-Exchange-CrossPremises-AuthSource: PAXP192MB1390.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 06
X-MS-Exchange-CrossPremises-Mapi-Admin-Submission: 
X-MS-Exchange-CrossPremises-MessageSource: StoreDriver
X-MS-Exchange-CrossPremises-BCC: 
X-MS-Exchange-CrossPremises-OriginalClientIPAddress: 178.38.90.75
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-Antispam-ScanContext: DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-Processed-By-Journaling: Journal Agent
X-OrganizationHeadersPreserved: PR3P192MB0554.EURP192.PROD.OUTLOOK.COM
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--8MJhscVP9zYeEr9F0a5o4xHjd2GMoHMMT
Content-Type: multipart/mixed; boundary="a54iPAvoSE8VIA6Dz2Uql5ClC19IhGnnm";
 protected-headers="v1"
From: Matthias May <matthias.may@westermo.com>
To: =?UTF-8?B?TcOhdGjDqSBLb3Bww6FueQ==?= <mathekoppany@gmail.com>
Cc: linux-wireless@vger.kernel.org
Message-ID: <8e6549da-1ea0-c5c4-3b09-7cbfde76f5ad@westermo.com>
Subject: Re: ath9k: unable to connect to hidden SSID on DFS channel
References: <CALOm-MsEcY7=MwfoEzhCQqSUM6qANy=oP5xYmoPqHAaADcscwA@mail.gmail.com>
 <1c9e0038-d40d-40a0-ac70-5bfcc8d8b95d@westermo.com>
 <CALOm-Mug=Js5HUhpdJH_djDjPm9u-x-6dYrNMCOLP5gaRBYQZA@mail.gmail.com>
In-Reply-To: <CALOm-Mug=Js5HUhpdJH_djDjPm9u-x-6dYrNMCOLP5gaRBYQZA@mail.gmail.com>

--a54iPAvoSE8VIA6Dz2Uql5ClC19IhGnnm
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13/10/2021 15:50, M=C3=A1th=C3=A9 Kopp=C3=A1ny wrote:
> Hi Matthias,
>=20
> Thanks for your fast and detailed answer.
>=20
> Could imagine my goal is something not allowed, or at least not the
> standard way. However, I still wonder what other devices do for
> achieving connection. Thought that this is just a limitation of the
> ath9k, but maybe they do something like you suggest.
>=20
> From your hints, I'd look into:
> [*] wonder why probing on DFS channels would be illegal?
> My understanding was that this is prohibited only if there was no
> beacon received from the AP before.
> But if the client receives a beacon from the AP (no matter if it
> contains a SSID or not) this shows that the channel is "clear" from
> any radar signal, and that the client is allowed to send.
> Is my understanding wrong?
>=20
> [**] would inspect the passive scanning code of ath9k, to see what my
> possibilities are to implement the above. Could you indicate some code
> to look into? I could not find it easily. Eventually, is some layer
> above ath9k also influencing the passive scanning?
>=20
> Regards,
> Koppany
>=20
> On Tue, Oct 12, 2021 at 10:30 AM Matthias May <matthias.may@westermo.co=
m> wrote:
>>
>> On 10/11/21 12:46 PM, M=C3=A1th=C3=A9 Kopp=C3=A1ny wrote:
>>> Hello,
>>>
>>> I have a project where I want to establish Wi-Fi connection to a
>>> hidden SSID, on DFS channel.
>>>
>>> I am running wpa_supplicant 2.9 on a device with:
>>> "Linux 4.9.51-yocto-standard armv7l" and
>>> "Network controller: Qualcomm Atheros AR958x 802.11abgn Wireless
>>> Network Adapter (rev 01)"
>>>
>>> Sounds an old project, I know, but want to bring this alive, if
>>> possible. Unfortunately, connection to a hidden SSID on DFS channel
>>> seems not working.
>>>
>>> However, it works on a different, newer device, which has
>>> "Linux raspberrypi 5.10.17-v7l+ armv7l" and
>>> "PCI bridge: Broadcom Limited Device 2711 (rev 10)".
>>>
>>> The wpa_supplicant on the two devices is mostly idem: same v2.9, same=

>>> runtime configuration, almost all config variables (wpa_cli dump)
>>> match (not seen relevant difference). There might be compile option
>>> difference, but don't think they are relevant.
>>> The only thing I see is with driver flags, where the newer device
>>> supports flags like DFS_OFFLOAD, BSS_SELECTION, or
>>> 4WWAY_HANDSHAKE_PSK, but the older device does not offer these.
>>>
>>> So I suspect the issue is due to some of the above missing features i=
n
>>> my ath9k driver (have default driver provided by kernel).
>>>
>>> Questions:
>>> - is it possible to enable the above driver flags/features for ath9k?=

>>> If so, how to enable and are there patches for these?
>>> - any hint where to look in ath9k driver for passive scanning
>>> implementation? Is there another module/location where passive
>>> scanning is implemented?
>>> - any suggestions for a solution to my issue?
>>>
>>> Thanks,
>>> Koppany
>>>
>>
>> Hi
>>
>> Clients not being able to find hidden APs on DFS frequencies is not a =
bug, but by design.
>>
>> Facts:
>> * When enabling hidden SSID on an AP, the SSID is not sent in the beac=
ons.
>> * Clients (non-master devices) are not allowed to transmit on a DFS fr=
equency unless an AP (master device) tells them it
>> is ok.
>>
>> This means that a client can find new APs only by scanning passively.
>> Since the beacons do not contain the SSID, the client will never find =
the AP it is looking for.
>>
>> Some ways around:
>> * Your client is a master and does radar detection (with all its downs=
ides), thus it is allowed to probe actively
>> * You hack your beacons and add a custom SSID which allows the client =
to get the SSID passively (hack both sides)
>> * Your device behaves illegal and sends probe requests on DFS frequenc=
ies
>> * ???
>>
>> BR
>> Matthias
>>

Probing on a DFS frequency is not illegal per se.
It is illegal for a slave device which is not performing radar detection.=


Take a look at https://www.etsi.org/deliver/etsi_en/301800_301899/301893/=
02.01.01_60/en_301893v020101p.pdf

> 4.2.6.1.4 DFS operation
> Slave devices:
> a) A slave device shall not transmit before receiving an appropriate en=
abling signal from an associated master device.

Simply receiving beacons is not enough.
You have to be *associated* to a master device (AP) to be allowed to prob=
e actively.


We implemented option 2 (custom beacon IE) for our devices, because we co=
ntrol both sides of the connection.
This doesn't work with 3rd party devices, but that is not an issue for us=
=2E Anyone with a sniffer can see the custom
SSID, we use it mostly to reduce the number of random mobile phones from =
connecting. It's not a feature that provides
any security whatsoever anyway, but more for convenience.


As to why some of the newer devices are able to connect:
IMO they they either perform radar detection, or are illegal.
Performing radar detection as a slave device has the downside, that if yo=
u detect radar, this frequency is blocked for
the NOP time (30 minutes), even if there are other master devices that wo=
uld tell you otherwise.

BR
Matthias


--a54iPAvoSE8VIA6Dz2Uql5ClC19IhGnnm--

--8MJhscVP9zYeEr9F0a5o4xHjd2GMoHMMT
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQR34wKNh4Jxr+4dJ/3fdrYEUzwNvgUCYWdCeAUDAAAAAAAKCRDfdrYEUzwNvoTY
AP4xQjOEt0DSOK/mTEbJFTgMr9/lvAbYT6/Of5g53+Jc/wD8CKYuDBYqEdeww5zkRwlqPv/lAkgA
uCtYsnyi58zFqgg=
=Aq0u
-----END PGP SIGNATURE-----

--8MJhscVP9zYeEr9F0a5o4xHjd2GMoHMMT--
