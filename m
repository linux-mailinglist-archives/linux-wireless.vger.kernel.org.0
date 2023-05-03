Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CA26F50F6
	for <lists+linux-wireless@lfdr.de>; Wed,  3 May 2023 09:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjECHOj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 May 2023 03:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjECHOi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 May 2023 03:14:38 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF9746BF
        for <linux-wireless@vger.kernel.org>; Wed,  3 May 2023 00:14:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElFoVtpGHzg4thVBxiP/iJ2ZFaGfecAjh5wv3QJ0vHoQ4bHMFDQ85s3QUAzFnKzoNEDr7COz3ROn6ZCfoGibsEonlvTybdLfeGTohZTaBgBE89Yjn52yPEVNNQ8gm+86gZTgfiBsuc2Oo7F8rWVBrGDnOgrZFm+rFhG/dE6Xf4P2MaWMvATelms6UZBY7O6bNdQ1IC7qrLhelRT90qPJwdvBPF+qxGiqFBjodNMtNJb6SBHDEZRKBI79mOpnscD0zYldjIipQkRQFEd5cRefGDgYvKSYoJVn+et4AKIJKnkiIaU8jTV8ehwhx56fUUyPrs1mX4Jxi3wEKXGyHdfQzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mF2NqvrBT5wCL1ppsXsQJZYSd8L/wRaDHNN7QfQhzWU=;
 b=RQpMBC8A2j0zHip5EKmZ7eilPJQFJ3YdxxbYVg41uW/+hIokymjOciUr0+gRh2rBNNEiQq5spsrOS9DG4IjUGYdA4AI5gMEH1hYoUZLrg5he64Pg9bqu50Xdwcw6qTyePbXzCGChbyWhiYsy24CdOLSk5BjA233qu42HoKJM6HW5t5o7IgH3eSXtEFInaDgYntapaouT68E2LorGJjsV+MJPVfqq6GbWX0exgskRuFfzIgYb3MOZWzeBfxwcyTUb/ue/fCaRtbozxQ7TbpHFZkQszfow1tuFpKVnmdrIXLOyLtGuZ/xDhiEVkx1skDPCzQnAiZNIHhQR6xB/7N4x/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mF2NqvrBT5wCL1ppsXsQJZYSd8L/wRaDHNN7QfQhzWU=;
 b=ZFdj8JS7Mh2eE1QYq/blqoT0kBT3D5tr/8vU0wf6QdmMQyj/E3qFKicX0XKy//fiIXwaPH54nm4P48v/eSMz6sHKteTdjAG8HY8f8xVKNaH8yeJzSg6pC5FBdgm5Ytj3i2F1bNo0/w/crX5RpMvIS7o46LYNbliqlg5ncrP2BYs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2843.namprd12.prod.outlook.com (2603:10b6:5:48::24) by
 PH7PR12MB6610.namprd12.prod.outlook.com (2603:10b6:510:212::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Wed, 3 May
 2023 07:13:39 +0000
Received: from DM6PR12MB2843.namprd12.prod.outlook.com
 ([fe80::863a:5f29:1e76:db60]) by DM6PR12MB2843.namprd12.prod.outlook.com
 ([fe80::863a:5f29:1e76:db60%5]) with mapi id 15.20.6363.020; Wed, 3 May 2023
 07:13:39 +0000
Message-ID: <75906666-df37-988a-c448-a6338b8a1cff@amd.com>
Date:   Wed, 3 May 2023 17:13:30 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Content-Language: en-US
To:     Yan-Hsuan Chuang <tony0620emma@gmail.com>
Cc:     linux-wireless@vger.kernel.org
From:   Alexey Kardashevskiy <aik@amd.com>
Subject: Slow RTL8822CE 802.11ac PCIe Wireless Network Adapter
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY3PR01CA0100.ausprd01.prod.outlook.com
 (2603:10c6:0:19::33) To DM6PR12MB2843.namprd12.prod.outlook.com
 (2603:10b6:5:48::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2843:EE_|PH7PR12MB6610:EE_
X-MS-Office365-Filtering-Correlation-Id: 7080c9f6-da8d-427e-b8fe-08db4ba5eaf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CpdQgTQWeFgIebaUs6MFafUiwns5SbA6XRQ/m4B0d/10GgUqTEEGtRzb8LLwLy3HQTLakwncmUvvOpavHKxHgBQrOUDClzZ1Btp/9jNsIqoVro6TeQMwsn51TnuiyzlpQpgxgXtm7m3bQCC8PhFh1eqoooQj0DqMqwcMFbkGRVfObuJdinzWorpe/WXpvz5WAUNfFMbsw8/8L8p/4DYCOxFc9Lw2zn1d4rDSt+pmH/aOSB/7wrslY0UhJHeRDANi/I3xCcvrpMoYwnSdUL740v2caoRx3fBKusNUI0vZKK8dHqYnowaTDoMQZUdzo1gF2ChV7e9IjFz9eeToaKzlvUqudzwr/5P2CUJ023zUYgqRKJyxTWbCVKr+Qe2QMhLS0pjUYaNcu8YbLYyfMM0GIgZVi1X7XVBvN3IBR90S71syL14s1FuWRqGOtjf4k8tBcX8bnTNDaDT9YsRYWYFz2pIOkfViUU/Gj4Md+1gaCmYumRB27FdqQPTxRXx5nTRgZq3OoyZI4TEWkl51G7br6jhK79GxLltddqVEZ3rY0qUMkAfUmlO4jGn2H3WsLH05HrObqhzqEgoXSTW06prJowR4cemX5lToKgrej4NAD1qFhevqq1ToDHyVArFmBt/MlFE6YdRkZczK9Duqj7gCMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2843.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(451199021)(31686004)(6486002)(6506007)(26005)(316002)(6512007)(38100700002)(5660300002)(8936002)(8676002)(31696002)(478600001)(66476007)(2616005)(66556008)(186003)(66946007)(83380400001)(4326008)(41300700001)(36756003)(2906002)(6666004)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1lqaGY0Yml2RmdrNzZ4WnRHb3RkWm1UU29MQ1RaM2VRN0kwR3FqRnZWOU9v?=
 =?utf-8?B?VHdqanQ5OWJBOXRhcUpDakxBS1l5a2ZmYmhJR2w0dlpTSjYvOWpicm1oTDll?=
 =?utf-8?B?dGZ6dnRMYmJsSTgxNTJsd1NQaGJTVm56eHNOd2poVlJ0M3IxYzBVbVRwQnhz?=
 =?utf-8?B?MmNJczJJOWYwSUlRWXhWajlCc3BVNmtmV2JnRUZiU2R5T0Zmd1dQemZJZ054?=
 =?utf-8?B?eXRHTlA2dk5OYmpSc1hKVXhpa2RRZDRLc0J5UVp6TzNERHh5RlczTkx1M2tv?=
 =?utf-8?B?VVIxQ04rNlovYU9xcGxKUTU4bFdZSHh5S0d1UXRwVk1KaVhkS2pEcUdEUng2?=
 =?utf-8?B?ZjV5ZUpNYUR1UnRpMStjSElLV25YejlBckxHcTN4UldSRUpQV3dzMlhHWUF2?=
 =?utf-8?B?UVFhQ0dNS2lkWlRGMFY2T2tZbUJCRHV4UUZORzhQUmhnUW9jdURFTFpOeEM4?=
 =?utf-8?B?UVJtTjRtWEJLREsxVWpPNWNKTURXWWNRWGlWUnZyRG42Nkg0UTNjdnkzMzlz?=
 =?utf-8?B?ZGJjTFc2WWFqa3ZvQy9BbE13VHVXVlY2UDRwbGxzY0h3a3JFNGp5cFlUYjdD?=
 =?utf-8?B?SDM3dEt5VHhVSWc1TjY2aFQwSVRXT2NBc0ZzNTF1R3UwSHVNelNCOHJVWE45?=
 =?utf-8?B?OXZja0M3VWZnLzhLVUlONDZLc3phZm1sZ012Zlo5WERhMjIrd1BhaEd6emxY?=
 =?utf-8?B?NUJ0R2NYU21zN0ZkRUwxOVUyYU9yODA1UjRCR21UWm00T1M1ZE94NnpjSjMz?=
 =?utf-8?B?ZmdyUHpGVndrWU44S1FFaUtJM0NhaFZBUE8xODhpaUtOU1NzRWpEWG1GWStL?=
 =?utf-8?B?VUpvMXFMRGpsckZvVWovVk53TkxoajNud2lIaldVaVppdFdTTEdPb01kazVh?=
 =?utf-8?B?K2dUTG94K1N2UUVzMjYwUGJ4UmJ1Kzg4ZEkyYzZvcVZkSWI2bkxJVU1aamlF?=
 =?utf-8?B?U25BUFIwVHgzeUJHbUdIVkpEc2xVYytETWcxNmhIeUhiUFFRODduU2xUM3lh?=
 =?utf-8?B?WCt6WUhjckJWWkYybWsyQmlQTGo4SXlOU2VrVTdOVUxQT3BFdUZTVlZiYjZ1?=
 =?utf-8?B?T2JSb0ova0IxZ1A3Qjg0ZG4yaVVFQzh1bzBGdWo3eC8wcC9mSzJ1NXRkbHo1?=
 =?utf-8?B?aGZnWC9sMDFJNEVydmg5U3hoRG1WTTJnd25Cdnlsc1hLR3F1WjN4dEFCdTBl?=
 =?utf-8?B?NG5YVnM1dU5CZ0IyR050QXRHVGU1UC9vUkZIdDA3aTJmTk5jZGV4cWpKSWNz?=
 =?utf-8?B?YXlxRUhETmFXYzhiei9OcmtnSjg5NDIvTkVlNlhXZ2NNN25FSTAzdURMYlRQ?=
 =?utf-8?B?VG5ELzF3aTBmZm9QdFZ4MWgvZ2pmRWp4dklFNHJVVFRuWnFWcWhrTUZwZnQr?=
 =?utf-8?B?Y3Z1cnNvU05UTzdFejZwWnlUYUh1Yk1BTzhkM2xwRTJsSkMrM0RRWFpoSytQ?=
 =?utf-8?B?UVE2MVplNUVsL3dnT21Bb0dqcEt3WGM5QmEzaW1VbzVZR2VVbStsYVU0WHMz?=
 =?utf-8?B?TldRQ0RjbENVWW0rY01haC9DM01UZmhPSE9xanlEMzI3bENkRnhDYlhyRFFw?=
 =?utf-8?B?SEhhUDJTODVEbVJkcWJNZnEyQlQ4Q3RtVHd2bGFVcTZFVVBWeXgrb1dwSWk5?=
 =?utf-8?B?V0ttc2hZZVB5OCsyZlhlOTQ2MFA0Q2hXN0RaRGlSZG5WRFFTa3JGcHZ3RTQr?=
 =?utf-8?B?Z2sraTNwMlVQeldrNVZIdTdjQjFUaDl5RVBBbXhwYzZ4OGU0TkRvSzlWU0wy?=
 =?utf-8?B?ZXA0eXYwWVdYR3RvZVdTT0d1ZVFmNllIWmZ5bWdXVmlEeTg2ZFJ6V3NFejBp?=
 =?utf-8?B?aDEyOTJCOXNZaTVyQVlyeC9lcE9OT1VJQjlkUFFadThzNU5maFBZeVE3UHAw?=
 =?utf-8?B?U1lyY0s5eG42Q2lFNmhVZUNvSjBUZXpPU2JETXIwSWg2WTJEdHNIWGZyeHFC?=
 =?utf-8?B?N2c0U2ZDZVEzOTVlNE5tUkNGeWt4ejVxRWpPS3pHMXBFYkt2OEJ4Y0V0Z1ZT?=
 =?utf-8?B?NG43aGZJRzBTSXdhNzN5R1h6dTAzWVRrd1oydy9NY21KVUw0M1dBSGtQVXFZ?=
 =?utf-8?B?OG9ndCtaY3N3dGlndVIxSUhPVmsrc0MxNXVGOUhLMjVRdXpqdXRPMlo3QnJR?=
 =?utf-8?Q?Hv/AMGjjbOo+tgPA1NJdMgE7/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7080c9f6-da8d-427e-b8fe-08db4ba5eaf1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2843.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 07:13:38.9765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YMRrIEaeY2RO1KDikZ3K37zQRue7eXSkT5svR4/8DHa0qS9tQb13oy1fTiNsutkK02HuzisrmUKfTA1wKXd31A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6610
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi!

I am seeing dropouts in 5GHz and 2.5GHz wifi and seeking for help.

HP laptop with RTL8822CE 802.11ac PCIe Wireless Network Adapter, 
Fedora36 with 6.2.9-100.fc36.x86_64, the AP is Ubiquity, it is 5m away 
behind a thin wall, a house in low density area (I do not see neighbors 
APs in "iw dev scan").

Pinging a gateway (1gbit ethernet between AP and GW) suddenly goes from 
3-5ms to >1000ms. Good and bad "iw" output is below. Moving laptop by 
2cm (or its lid) helps sometime.

These 2 observation made me suspect the linux driver:

1) If I reboot the laptop to Windows10 without moving/touching it after 
it went bad in linux - there pings are 1-2ms and occasionally may go up 
to hundreds but for a very short time, feels like the driver notices 
something and fixes it.

2) Two other laptops with Intel Wifi cards on the same spot with the 
same fedora on the same network do not show the problem at all.

Changing txpower 10..23dBm (where 2300 is the maximum) does not help, 
done via "iw dev wlp1s0 set txpower limit 2300", "iw dev wlp1s0 info" 
confirms that it changes.

I have these in /etc/modprobe.d/50-rtw88.conf
options rtw88_core disable_lps_deep=y
options rtw88_pci disable_aspm=y
no change either.

Is there anything else to try? Thanks,


64 bytes from _gateway (192.168.10.200): icmp_seq=26 ttl=64 time=6.97 ms
64 bytes from _gateway (192.168.10.200): icmp_seq=27 ttl=64 time=3.68 ms
64 bytes from _gateway (192.168.10.200): icmp_seq=28 ttl=64 time=3.44 ms
64 bytes from _gateway (192.168.10.200): icmp_seq=29 ttl=64 time=3.97 ms
64 bytes from _gateway (192.168.10.200): icmp_seq=30 ttl=64 time=3.68 ms
64 bytes from _gateway (192.168.10.200): icmp_seq=31 ttl=64 time=17.0 ms
64 bytes from _gateway (192.168.10.200): icmp_seq=32 ttl=64 time=33.1 ms
64 bytes from _gateway (192.168.10.200): icmp_seq=33 ttl=64 time=697 ms
64 bytes from _gateway (192.168.10.200): icmp_seq=34 ttl=64 time=1130 ms
64 bytes from _gateway (192.168.10.200): icmp_seq=35 ttl=64 time=114 ms
64 bytes from _gateway (192.168.10.200): icmp_seq=36 ttl=64 time=1796 ms
64 bytes from _gateway (192.168.10.200): icmp_seq=37 ttl=64 time=749 ms

Good status:

[root@aiemdeew wlp1s0]# iw dev wlp1s0 info ; iw wlp1s0 link
Interface wlp1s0
	ifindex 2
	wdev 0x1
	addr 50:c2:e8:5d:ba:fd
	type managed
	wiphy 0
	channel 36 (5180 MHz), width: 80 MHz, center1: 5210 MHz
	txpower 22.00 dBm
	multicast TXQ:
		qsz-byt	qsz-pkt	flows	drops	marks	overlmt	hashcol	tx-bytes	tx-packets
		0	0	0	0	0	0	0	0		0
Connected to f4:92:bf:04:1a:ce (on wlp1s0)
	SSID: aikhomenet
	freq: 5180
	RX: 37035326 bytes (60439 packets)
	TX: 2880943 bytes (14231 packets)
	signal: -53 dBm
	rx bitrate: 130.0 MBit/s VHT-MCS 7 VHT-NSS 2
	tx bitrate: 390.0 MBit/s VHT-MCS 4 80MHz short GI VHT-NSS 2

	bss flags:	short-slot-time
	dtim period:	2
	beacon int:	100


Bad status:

Interface wlp1s0
         ifindex 2
         wdev 0x1
         addr 50:c2:e8:5d:ba:fd
         type managed
         wiphy 0
         channel 36 (5180 MHz), width: 80 MHz, center1: 5210 MHz
         txpower 22.00 dBm
         multicast TXQ:
                 qsz-byt qsz-pkt flows   drops   marks   overlmt hashcol 
tx-bytes        tx-packets
                 0	0	0	0	0	0	0	0               0
Connected to f4:92:bf:04:1a:ce (on wlp1s0)
         SSID: aikhomenet
         freq: 5180
         RX: 38078401 bytes (68758 packets)
         TX: 3039702 bytes (15006 packets)
         signal: -62 dBm
         rx bitrate: 117.0 MBit/s VHT-MCS 6 VHT-NSS 2
         tx bitrate: 433.3 MBit/s VHT-MCS 9 80MHz short GI VHT-NSS 1

         bss flags:	short-slot-time
         dtim period:    2
         beacon int:     100

-- 
Alexey
