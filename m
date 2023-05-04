Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC10B6F6326
	for <lists+linux-wireless@lfdr.de>; Thu,  4 May 2023 05:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjEDDKi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 May 2023 23:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEDDKg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 May 2023 23:10:36 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F06D7
        for <linux-wireless@vger.kernel.org>; Wed,  3 May 2023 20:10:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTHsmyWHwQJjFKpujqjrcH2dmHYwXaVKyyMHNIyD/z5Opbq40h9iDxe0lRB05Uwm2a2wnT5w+gAiG/g5L925OMpyP2a9/zvb3lk398hbGDQWgP95pWfqjo/gMXvNzh4+nY7omdyGzb06pE0vWp9LAOSbtRbwYviHGaKdewecuwPKb0j5b10aReCcrQXXIe9mlvw1yVK4BZ3dBRMRS/EwUNYgr2oyg87ojytdW1WTI1yF9hc8ty3ILm8K+FL/JHavf04PIqCCY6fxOY6ROsTm3ZqBps329k904apG1NjqVR5HDoLo8utg1oVy2qAvwpa3QG2pXPdUuOCeo2ae+W0l8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jy94da4rWAdYKUH5Y+rZpsTVE8wfvu8qbGyukaxC6Sc=;
 b=m7lHSOMU79v51rdpRVWC0uehPaGCmi7AAGoNJtGJKBWm+EKZkg7mqJGdU+CmIRYiUbL5+vuhGpg8U5QuJosKVnK+amDXWhefiftdUubZr4fpLeSLFnBVvR8VJVvMiO4jdp0e+VliuY5bkMpupfr3ce7rSWoLmvFw/u3/ioHAxckP/Baqt+pkkCEYfP96aiQBw5qH3uXfF9efN3dguoKH2G/p1DQsWP4dn/3HGS8MVVKhNVtSfjMx8gJOURPeDyO12vun0G9bVa7tYBFiAbxuBUHOWLXEUIkXjiFNS8XxGF8Mvxdkx6qGMaiXir+r7i2tz4yIcBxrviHEIkjpWXzjlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jy94da4rWAdYKUH5Y+rZpsTVE8wfvu8qbGyukaxC6Sc=;
 b=J5RzlSAtgpmer/HTb8Zvx2MXlF+D+l91gZ/cRgGJwTi1Ez3jJ6v+dTrv7Xf4RflKbqxUOOII5+gE7y+biEZBdruLs8qnFvIuO4tqsZRoVLs5PYPj/p1D/1o5HwsuOTnN+q4JndmuAT5ttdU2FUz+EVnn1DzHpdi9su0oINI+0S0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2843.namprd12.prod.outlook.com (2603:10b6:5:48::24) by
 LV3PR12MB9119.namprd12.prod.outlook.com (2603:10b6:408:1a2::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.22; Thu, 4 May 2023 03:10:31 +0000
Received: from DM6PR12MB2843.namprd12.prod.outlook.com
 ([fe80::863a:5f29:1e76:db60]) by DM6PR12MB2843.namprd12.prod.outlook.com
 ([fe80::863a:5f29:1e76:db60%5]) with mapi id 15.20.6363.020; Thu, 4 May 2023
 03:10:31 +0000
Message-ID: <4b3f4c5b-cada-bb7c-65f3-936437261b08@amd.com>
Date:   Thu, 4 May 2023 13:10:24 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: Slow RTL8822CE 802.11ac PCIe Wireless Network Adapter
Content-Language: en-US
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Yan-Hsuan Chuang <tony0620emma@gmail.com>
Cc:     linux-wireless@vger.kernel.org
References: <75906666-df37-988a-c448-a6338b8a1cff@amd.com>
 <b7a59145-37b0-eade-3a9e-b565cc75de35@lwfinger.net>
From:   Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <b7a59145-37b0-eade-3a9e-b565cc75de35@lwfinger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SYAPR01CA0040.ausprd01.prod.outlook.com (2603:10c6:1:1::28)
 To DM6PR12MB2843.namprd12.prod.outlook.com (2603:10b6:5:48::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2843:EE_|LV3PR12MB9119:EE_
X-MS-Office365-Filtering-Correlation-Id: aa07f759-99d5-4fe3-8422-08db4c4d1e6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vob3BwyKQf69I51ZmcFfmXiIoe/xNfaYf84QOa5yPrnNc0IJhcNMDoJA12emUqMBuDY3TKSDW4HXXjUwHLmvAsgFMn5ijI6BgiCPQ7ECw2yGmhUvBOFmG3cHe2WFufcrUN09zShnA7WmuG1sWMsMPhkF2tNCPNK2gyfWIgJ7pXtQ+EzHxKFk76xJmDJcLLamdi0CG9pERJLeY8/nA78C/FsorDPg4PSyi6qpZUEBuZszpHdLEB8VvBSETcbzmwVd+xaX4r48RCI5HY2KaLIZyjJSN6psnyLOcyQXo0zNHzosmqHmHnPmV07iwJP38UdMFGQQ9G4MDxmE4BF9kBKSW0HiYw46aPzEUGXS4j13rDdY77+sj65de7KdbT2/aKgvBaiv3WTHXFRgMRUzU2qBrDxxn4adtkRgCPzJeHcc6duEAqAizS4+ViWU6BxCic0ZWCi4c2C4L8i1CrPMzB2ObJGzlTrkGhr1EBB/cBuGtxS9Dz1Kt97VyAhfsq0Qt2rEX2tzbm/bRarzF9o73YmId8aD24xqvAVHoyA5eJ/b4bCULNkTtwRtr5/GZbftZsDen+eAegvldQSuvHaA2bJgkjNZSGOnM9BPcG69Ww0c2eVQ1EAB4/z3vNFlogwHlsJZvCUtXpIMKywUMhl2LdcJEx/PyUNAPoNzzHB6VAzlJNI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2843.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199021)(2906002)(6512007)(6506007)(26005)(83380400001)(53546011)(186003)(2616005)(41300700001)(6486002)(6666004)(5660300002)(966005)(8936002)(8676002)(36756003)(66476007)(66556008)(66946007)(478600001)(316002)(31686004)(31696002)(4326008)(38100700002)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEl4M1NoUDBNeG5YaytwMU1nVVFmMmwwMS9xazQrakFGQXdNQWIxUDRoZ1Fu?=
 =?utf-8?B?YnFtejBnVHBKbXQ4c2daazFpc21KZ1RGL0xNdlllVVJCUEVZcFBsOUpYMnhJ?=
 =?utf-8?B?bDdRaEhZRk83cVA0RlliY2RzbkFJOTgxR3JveDZxNHhHTmI1cis5MEdLcnAr?=
 =?utf-8?B?TjZWMk1mRVdmSmFhOENrUklkVTdiUmpCMlpERVZxdFlJekNMOFNzZmFhSmNN?=
 =?utf-8?B?T2UyMCtWVUVSVG5ISzJ3WVBkVnZ6S3FId2NSa0Yrcmx2MWNjY3YyMXdJckRX?=
 =?utf-8?B?MkdYQy9STUVBSngvWEIreG1BOE5QR29kU3lzenFsUDRwclhsT25vcG5uQVBu?=
 =?utf-8?B?QTRTWTJRNCtTWFN2TzRFNUEraDliUUlrdW9aWmlxM1JrOTE3MTNKMlpPNFpo?=
 =?utf-8?B?RE1lQnpUS0xUdjBNOE5BZDA5bW9wUm1udVVFdTFJQ0svZndza0pJcWRkdXln?=
 =?utf-8?B?M0pod1lnSFp0Yy80ZmZvdE42V041MmJoV2xOMEh1a2ZadFJCRUtha1dzR2lD?=
 =?utf-8?B?MlErYlFFUDdVRXdaMTZONWhDVW52RFVXZVF5aWdoZkx6TnlMeUdqNjFXTCsv?=
 =?utf-8?B?ejR1d25NK2M2QXRjNkhGYnhHVzk1NjM3SWEzbnZudVRmN2ZGWnNkbjhhVDRB?=
 =?utf-8?B?aWJNN3BHSWI0V01NZjU5Y2ZMK2NOL1NjVXhuYXZ2eFNyUiswdlJiM2dKTzJ6?=
 =?utf-8?B?Y2E5MU10ZkZSR0QzR28wQTlIZ1kvQ0dybk1Pd2VVZ2c3VjhMaCtmazdnT25m?=
 =?utf-8?B?aVA0TjN4Lyt5WTh1czF6M1RFWWlPR1dORlBPWGMwaVAwb2lraVVuWjQ2M3hv?=
 =?utf-8?B?YWpCaCtQOGptVU43YWJ0UFVsS1RpUnJwMWJ0R3ppNnZ6N2VJUlNiRmxHck1M?=
 =?utf-8?B?Vzd0aExXaXZJeG9DaEprdmtxTWs1RWRkRFdnWTFuck1qcXo2RUdoSlllRVEz?=
 =?utf-8?B?TWhYVUVjT1ZvZ1Y5MHpyRDNKaGhsd0kzVml5R2t0VTEyOE5zdm12aUJ4dFM1?=
 =?utf-8?B?TElnSUl5L21UTE1OTkc2U0pOb2RsU28vbEpvQWRoaXg1alhBekJ1S1RZYVpS?=
 =?utf-8?B?MUMzTm9saTN5UDUwT0dURVBwMnFTVUpaK3dmYmQvNXJ5Qkh3YWhWUDA3ZFln?=
 =?utf-8?B?YWdIeU9WT2lSWitpM0dDSkRTNDRPMktBemFPSTM1QTAwQWhVaGFmNVJkQzRY?=
 =?utf-8?B?enB3cERGd2lmS1NSckhjTk1WRVJuUHBSSXpxM09rZkNDRHBzWmdyZEN3ZEtz?=
 =?utf-8?B?S1pwWWRwK1AzVFYvdGladjVBVURYdWtmeDJ2WUpKY3lyei9UMnIza2JOSDJI?=
 =?utf-8?B?MHRZL0NTVVl1QVJ3clZsbnlqR2FIS1JScTFyV291c0ZjL291ZXhSS2lzQXQy?=
 =?utf-8?B?M1MzQmVzd3hVVFJ2MXRWZStSUkptYnNNR2NRakQzcEoxNW1BdWhSZkhWZElQ?=
 =?utf-8?B?a0dGcmxPcGtsdUhiUE85OXpuNlAyR2VpNGpYOVpNMEI4azU0RTZDRkZNamd0?=
 =?utf-8?B?NlJIbFh3MXJaa25XSGZjNTByaFdQN3hjSURvUlVRWGRxOTg4NjM0QTVGc2VB?=
 =?utf-8?B?Ynd5a2czK1FCZDdPQ0M3WUpjaklNQmZQSFBmS2F5RmdlMklrZW5tdDZBbSth?=
 =?utf-8?B?WEdvQTlXNXFPS0dOeEdEbXBpbEdUQnJuLzROTzZHRlFzKzZRcUJJUTJza2k2?=
 =?utf-8?B?Ym50N1pPVE04T1JPL1RndzVCODcwUGRnSGNrUUc0RW1hUmQ3WDdhN0hDcEJK?=
 =?utf-8?B?ang0aXYvRXo4VEY3eTl5U2RSTzcwQzlZa1VxMTdGU3hLTGJ6dzJGbWhBNjI3?=
 =?utf-8?B?MUpvaTg0ZDJ2aXUrSEJKUmxtekF2Q29MMDJvVGE4UzN0TDUzbUJWbkk1eTgw?=
 =?utf-8?B?ZTRnZEh2M29xRlNDekhFS0hVNTJiRUdBSXY2TGhqQ2prVVdOSkRndzdLNzdW?=
 =?utf-8?B?TWlqYWVDRG0rcWJwWnRqNTR0bXQ4bUNXelJXVzVpdGRIQUdmTC9wN2FZVFJl?=
 =?utf-8?B?NDFFbTU1VFFDb3RDRWZla1krSmdKbkpva29ZSEhnak5BQSt3SkZhRExyLzZF?=
 =?utf-8?B?UmdVTlZYOGRtWWJBcDhiRlJPbzgwaGZ3U3ZoUlVkVks4Zzc1akpVR2RtUVNs?=
 =?utf-8?Q?N9vHcjiaxAH0sviUJOuFEpnE+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa07f759-99d5-4fe3-8422-08db4c4d1e6e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2843.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 03:10:31.2700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fhH/yY71u1KsR+CezzPyeTetsuMsgmg7zvBlUNRDuPa/Jb9bBPM5EQsx7Cqg9s44bJSWuAqXI2LAXipGM3Qg5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9119
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 4/5/23 00:42, Larry Finger wrote:
> On 5/3/23 02:13, Alexey Kardashevskiy wrote:
>> Hi!
>>
>> I am seeing dropouts in 5GHz and 2.5GHz wifi and seeking for help.
>>
>> HP laptop with RTL8822CE 802.11ac PCIe Wireless Network Adapter, 
>> Fedora36 with 6.2.9-100.fc36.x86_64, the AP is Ubiquity, it is 5m away 
>> behind a thin wall, a house in low density area (I do not see 
>> neighbors APs in "iw dev scan").
>>
>> Pinging a gateway (1gbit ethernet between AP and GW) suddenly goes 
>> from 3-5ms to  >1000ms. Good and bad "iw" output is below. Moving 
>> laptop by 2cm (or its lid) helps sometime.
>>
>> These 2 observation made me suspect the linux driver:
>>
>> 1) If I reboot the laptop to Windows10 without moving/touching it 
>> after it went bad in linux - there pings are 1-2ms and occasionally 
>> may go up to hundreds but for a very short time, feels like the driver 
>> notices something and fixes it.
>>
>> 2) Two other laptops with Intel Wifi cards on the same spot with the 
>> same fedora on the same network do not show the problem at all.
>>
>> Changing txpower 10..23dBm (where 2300 is the maximum) does not help, 
>> done via "iw dev wlp1s0 set txpower limit 2300", "iw dev wlp1s0 info" 
>> confirms that it changes.
>>
>> I have these in /etc/modprobe.d/50-rtw88.conf
>> options rtw88_core disable_lps_deep=y
>> options rtw88_pci disable_aspm=y
>> no change either.
>>
>> Is there anything else to try? Thanks,
>>
>>
>> 64 bytes from _gateway (192.168.10.200): icmp_seq=26 ttl=64 time=6.97 ms
>> 64 bytes from _gateway (192.168.10.200): icmp_seq=27 ttl=64 time=3.68 ms
>> 64 bytes from _gateway (192.168.10.200): icmp_seq=28 ttl=64 time=3.44 ms
>> 64 bytes from _gateway (192.168.10.200): icmp_seq=29 ttl=64 time=3.97 ms
>> 64 bytes from _gateway (192.168.10.200): icmp_seq=30 ttl=64 time=3.68 ms
>> 64 bytes from _gateway (192.168.10.200): icmp_seq=31 ttl=64 time=17.0 ms
>> 64 bytes from _gateway (192.168.10.200): icmp_seq=32 ttl=64 time=33.1 ms
>> 64 bytes from _gateway (192.168.10.200): icmp_seq=33 ttl=64 time=697 ms
>> 64 bytes from _gateway (192.168.10.200): icmp_seq=34 ttl=64 time=1130 ms
>> 64 bytes from _gateway (192.168.10.200): icmp_seq=35 ttl=64 time=114 ms
>> 64 bytes from _gateway (192.168.10.200): icmp_seq=36 ttl=64 time=1796 ms
>> 64 bytes from _gateway (192.168.10.200): icmp_seq=37 ttl=64 time=749 ms
>>
>> Good status:
>>
>> [root@aiemdeew wlp1s0]# iw dev wlp1s0 info ; iw wlp1s0 link
>> Interface wlp1s0
>>      ifindex 2
>>      wdev 0x1
>>      addr 50:c2:e8:5d:ba:fd
>>      type managed
>>      wiphy 0
>>      channel 36 (5180 MHz), width: 80 MHz, center1: 5210 MHz
>>      txpower 22.00 dBm
>>      multicast TXQ:
>>          qsz-byt    qsz-pkt    flows    drops    marks    overlmt    
>> hashcol tx-bytes    tx-packets
>>          0    0    0    0    0    0    0    0        0
>> Connected to f4:92:bf:04:1a:ce (on wlp1s0)
>>      SSID: aikhomenet
>>      freq: 5180
>>      RX: 37035326 bytes (60439 packets)
>>      TX: 2880943 bytes (14231 packets)
>>      signal: -53 dBm
>>      rx bitrate: 130.0 MBit/s VHT-MCS 7 VHT-NSS 2
>>      tx bitrate: 390.0 MBit/s VHT-MCS 4 80MHz short GI VHT-NSS 2
>>
>>      bss flags:    short-slot-time
>>      dtim period:    2
>>      beacon int:    100
>>
>>
>> Bad status:
>>
>> Interface wlp1s0
>>          ifindex 2
>>          wdev 0x1
>>          addr 50:c2:e8:5d:ba:fd
>>          type managed
>>          wiphy 0
>>          channel 36 (5180 MHz), width: 80 MHz, center1: 5210 MHz
>>          txpower 22.00 dBm
>>          multicast TXQ:
>>                  qsz-byt qsz-pkt flows   drops   marks   overlmt 
>> hashcol tx-bytes        tx-packets
>>                  0    0    0    0    0    0    0    0               0
>> Connected to f4:92:bf:04:1a:ce (on wlp1s0)
>>          SSID: aikhomenet
>>          freq: 5180
>>          RX: 38078401 bytes (68758 packets)
>>          TX: 3039702 bytes (15006 packets)
>>          signal: -62 dBm
>>          rx bitrate: 117.0 MBit/s VHT-MCS 6 VHT-NSS 2
>>          tx bitrate: 433.3 MBit/s VHT-MCS 9 80MHz short GI VHT-NSS 1
>>
>>          bss flags:    short-slot-time
>>          dtim period:    2
>>          beacon int:     100
>>
> 
> Something certainly changed for your signal strength to drop from -53 to 
> -62 dBm. The higher value is acceptable, but will not provide high data 
> rates. The lower value is marginal.

Well, one of the other laptops (Intel nic) reports -68 dBm and pings are 
solid 2ms. The one with realtek reports -61dBm and pings are 3.5ms+. 
Never saw 2ms with Realtek in Fedora but I saw that in Windows10. But 
probably Windows' ping calculates times differently :)

> There are some changes between kernel 6.2 and the current contents of 
> the wireless-next repo, which is the code to be found in kernel 6.4 when 
> it is released. Could you try the code in 
> https://github.com/lwfinger/rtw88.git? This repo has the code found in 
> wireless-next modified to build on older kernels. You would need to 
> blacklist rtw88_8822ce. This sequence should do it for you:
> 
> sudo dnf install git kernel-headers kernel-devel
> sudo dnf group install "C Development Tools and Libraries"
> git clone https://github.com/lwfinger/rtw88.git
> cd rtw88
> make
> sudo make install
> sudo touch /usr/lib/modprobe.d/50-blacklist-8822ce.conf
> 
> As root, using your favorite editor, add the following line to the above 
> file:
> blacklist rtw88_8822ce
> 
> Then reboot. Report if there are any changes. This way, we will be able 
> to determine if the problem has already been fixed.

My bad, I should have mentioned that I tried this one as well, 
https://github.com/lwfinger/rtw88/commit/75e2c81 3weeks old, no 
difference there.

And it does not look like there was any change related to my problem 
since then, is it still worth trying the very latest version? Btw reboot 
is not really required, it is Linux, not Windows, rmmod+modprobe should 
do ;) Thanks,


-- 
Alexey
