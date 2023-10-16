Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C5D7CA881
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Oct 2023 14:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbjJPMv6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Oct 2023 08:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbjJPMv5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Oct 2023 08:51:57 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2055.outbound.protection.outlook.com [40.92.98.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE1E9B
        for <linux-wireless@vger.kernel.org>; Mon, 16 Oct 2023 05:51:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Go8s7Owx4G+xd7aZ6U+D5IgsZ8iIO4cveBl3XVK0L8hupUJXdeBnsZXgp3PlztKBsZf92Q6T+/K5EIBj3r4dmifQT4UZzYQazpz7v8yomTY/pzIcX9eNwQrKi298WNI8hR9plHEJyN62/9ptxxNpvNQ3nXpy7VP5QrHMoqOVh82eyd97sQVonpQtcr1KZfW/9BmTOQwhE2OH7s/g81VgekgXkZwroRBRwB/iDl/GaP44yce3c/0P0gK3G7/N1GiNXPpSawWpkyuSlonShHvfwBbn5107PPC/bpOC03NZs8t5GmUcuJijq7T3C0vKa+o1PcvjwE41BJs7ejp7HvCVrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/sPTS0yLRiqz0takNQ+rZAR5nlyidFlbAswRCYpcEgg=;
 b=QFkZHJKdwzeVQDDWf8i+Ie3tmgG3thODeY6kl9qU+nNsZLwACzNmRXsxjamwGnNhY20jt8tdKKmZVlVP/T9PfOU/TDF59qg1VrsCsTB6sFZEjNViXizb77pBlkWuGTtF234XxX0IFweaF1sfaQnpLnodOWvWSkJVJQl6IEpnPyYjPRX4DnQYx7GRVR9a5vs/HL0am2mYaZhOu0AStMZWCI/QiWoTgYgrqHYMO8Ri8EU0BZBJQUNtCv43XojYzLPUt+nEKTKk9FrBtL0DTLChy3/t314KpkMVphZ+XooFvJTSwosKt+k201/91GBvA3ukr/7vv1izSkdi+8J4OxDxEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sPTS0yLRiqz0takNQ+rZAR5nlyidFlbAswRCYpcEgg=;
 b=pCXTlqoj2ezUsODOaiJXSrrhA1v3sgN5Cu6ONyVTDl+ffkSPRHmyp0ky/NjT8qAsn1G5nQKKfop6M9wLnfh0mh6u58Fes0G4pslyhm3oURJQVmWN1IWaBipdhF0kU4+HliLgyiAQQlNbetWtZ+G6A0msASO+Z77UDkVdPxYxav976DL9/vxXmkiVHR6TNimS+8pb/HhyvO/8TdiMxSS7zY3Pf7TaCLmiYara9miqc7p9D7a9qU7L6HxDfOZagfIHnzHpVocQnQLJSrYBOFqiYb75FQno5xOQkdPPDIX9iTE5g68Wx4LGqxM4zMBQkHgT3bIqKooV1CdMAB5uPthE/g==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TY3P286MB3847.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.16; Mon, 16 Oct
 2023 12:51:50 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bbb1:a301:f7b6:744a]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bbb1:a301:f7b6:744a%4]) with mapi id 15.20.6907.018; Mon, 16 Oct 2023
 12:51:50 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     stf_xl@wp.pl
Cc:     helmut.schaa@googlemail.com, kvalo@kernel.org,
        linux-wireless@vger.kernel.org, yangshiji66@outlook.com
Subject: Re: [PATCH 3/3] wifi: rt2x00: rework MT7620 PA/LNA RF calibration
Date:   Mon, 16 Oct 2023 20:51:38 +0800
Message-ID: <TYAP286MB0315F5964611DCECB291CBD8BCD7A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231014175548.GB477888@wp.pl>
References: <20231014175548.GB477888@wp.pl>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [+A91M4l0JOny2qUhANvzFXsZvd0hNVSu]
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20231016125138.32301-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TY3P286MB3847:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f7e1d57-953a-47ef-1002-08dbce46aa0a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2S275YCu/1Njy2KMpJcX3VP0jeVdWB9SGkClyYp0wzYIpR3aiuOGw+8l6lvx7K9ndUJHzY1OUOt2mGTMTcDGck0Vxn8FGNy3OkflzFs+zvbWT5JYLUrUcVFJTctejeMIY2sORuV17Z2+5aYmftObrLD4dR/557T2C0DoiAwVW5WMelXQ2nvjr4/4Sj3eAcOcLWSUFHHPoOQmSux7rx/VW1+eulMmQs0awxZf2iAz+SgV3nxMgddIGtpc0jR8XefsazCmO++2y0VkvbkuPhfGZ3PuStgCl3THMghQ5rBWkluQmAcAzYYkIcoTMbh4oJfPq8fUstFFQ3xXm3sgGtJOFhZbe9EyprdxYlgKpEK8CLMLVttwOO5sAidsQAggvyvl+YaeYb6kbiYGXpcN7pCeMyBB4Tks/d7do2SoX8ks0epINjYuon2dS9qj9x9qkU0lXMfgXAaXXvzSm7lZvItrMeGHD0x7pHMQKAkervZLZYSqiLpeGjFnNPO/LIfuHg8PYvUJcugwIVXJTz8xmfO+x1qj+HKwXLQusZHIBjVjtdGbyQJlcs9Vlj4RRiY6i3CSgskChy5GpJgYYEF7+G1P31NMS70HEudn2cDorowqK68GRo+5bF40T79tvdxE95yE
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hHWCVpJO2Lk+kAMithyIP7RFVYGDnI0aEF1+D3ZfCn3pkO3BmCjjkdUDhDf8?=
 =?us-ascii?Q?z382+5StnqTj8gJSw/mmH2X1IexBt00OFOJhlLou8W6qs6JSniu62vgnjqOr?=
 =?us-ascii?Q?8qjMJb/BDsoQcrihL5Xq5SC87g9UuqpvLC0PwjOVMA4gMz9fcwa6hLMdvmI+?=
 =?us-ascii?Q?lTuwUFerNT4nzF1YAsVmIQGS3yZhtw1gA7cUu3Or+cLaIee0ndYZii17U195?=
 =?us-ascii?Q?Ry7O8650Z6HERlWDGENEW0H3XusyNUlF1fLCSqnK54sNUEUq4yKCyXMpO+fp?=
 =?us-ascii?Q?7hbtmsnL2pUJOmroxW9btr6y8jd4ubErQuE4htbs8iqj9KFR/0ly0d5lqKdE?=
 =?us-ascii?Q?rIZ1F/mjCLHgbsTld9+sUqxTAt5c0ycYX7YzgzuD/cETgVY36ueN3TcDjIHn?=
 =?us-ascii?Q?VBGYQ0qwpiTh6Sg5LMCUxXhcKOFgKy/qahHg1uryfTQ4Yqb99IeEYXvmomWI?=
 =?us-ascii?Q?HDi+Bje8jaILQYxwZk47cQ1SQCrEPoUMc5jdRsN5goNDWP1K4L+vQew0rUta?=
 =?us-ascii?Q?b9dmyPm+A/MOMrt/WkHJD6GPoJlsqlSllHo/ydEMUE9a+nd8FkUKHHHuP87P?=
 =?us-ascii?Q?szHPhGZPOOUT6Gr2ihODw3l4YFJg2AMN4MpzoQHFKw0Kg8uw/BS1+kOLoy9p?=
 =?us-ascii?Q?qtB8dpDk2uxOqW3EeAXhXj+SLqMJa7MS60J9FdZamKV3BQCxR9Dxi6xaR7XR?=
 =?us-ascii?Q?KQFFYyHNSDka43odUC2oruVxEMYNDXb38gSnqZapv+nnjMWIvxi+8LaHTpe0?=
 =?us-ascii?Q?9eV1creCZTgxqXUMpv7vt1iSVTAroZ9gi4bJXMIfyA7Q1j6tZc90Pr88R511?=
 =?us-ascii?Q?K93zYD7YvoGZrPoNX9zCwKlPUH3rBfARMCjGrdt98l9cWxly+oDO2NPXElg2?=
 =?us-ascii?Q?Jcy5NyQWqwIlgHN1djb2lvsX/OGruCMm7XBLJt+WfjPCiYE9J1ONxxXP9Ljx?=
 =?us-ascii?Q?upNd50BdgZcuXZ3CYcGEH67VZDoSBTHEM8R/Gnqc0npMwIAEZn0VP0TFcMrk?=
 =?us-ascii?Q?XxVFrC/rcSCmi3YAMNPHXFaTCG4Vg6CA0MkVYobBtH6gvl/1BoWixa/udnpg?=
 =?us-ascii?Q?xp7GGkb6Ii2RHfRpZL20uKgVa/pe4DQQPH2irwjlxYNKUx3EIoZDdted2kHR?=
 =?us-ascii?Q?hN+wgCVDI3djnzirCJM+tbrK5q8SxFjA1zeN7bk1ibadgZ4sJjChKciwFReS?=
 =?us-ascii?Q?A+yjvtQTpGaJn9hxLY+DjmInZ6cZLmn5eYT56pBEJLVyL8eBLRRPyB5flOQ?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f7e1d57-953a-47ef-1002-08dbce46aa0a
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 12:51:50.6352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3847
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 14 Oct 2023 19:55:48 +0200, Stanislaw Gruszka wrote:
>On Sat, Oct 14, 2023 at 07:21:30AM +0800, Shiji Yang wrote:
>> 1. Move MT7620 PA/LNA calibration code to dedicated functions.
>> 2. For external PA/LNA devices, restore RF and BBP registers before
>>    R-Calibration.
>> 3. Do Rx DCOC calibration again before RXIQ calibration.
>> 4. Add some missing LNA related registers' initialization.
>> 
>> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
><snip>
>>  int rt2800_enable_radio(struct rt2x00_dev *rt2x00dev)
>>  {
>>  	u32 reg;
>> @@ -10762,6 +10831,10 @@ int rt2800_enable_radio(struct rt2x00_dev *rt2x00dev)
>>  	rt2800_init_bbp(rt2x00dev);
>>  	rt2800_init_rfcsr(rt2x00dev);
>>  
>> +	/* Do calibration and init PA/LNA for RT6352 */
>> +	if (rt2x00_rt(rt2x00dev, RT6352))
>> +		rt2800_calibration_rt6352(rt2x00dev);
>rt2800_init_rcsr() -> rt2800_init_rfcsr_6352() is called right
>before this. Could we have rt2800_calibration_rt6352() there ? 


Yes, It should be better to do that. I'll change it in V2 patch. Thank you!

>
>Regards
>Stanislaw

Regards,
Shiji Yang
