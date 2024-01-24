Return-Path: <linux-wireless+bounces-2442-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 605B383AAA2
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 14:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B56A3B2BBB5
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 13:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CC677640;
	Wed, 24 Jan 2024 13:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=locusrobotics.com header.i=@locusrobotics.com header.b="F38fPzqH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2137.outbound.protection.outlook.com [40.107.94.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAD7768F0
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jan 2024 13:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706101594; cv=fail; b=q/AnOC0lEYXGjWFn7awz8gGdJrOUbMhc2Et51h4oncnN+zGdb/UfUsXzZqSfS9iIRzKnmSLw3DxMLzJB06Xtt45wva7dzvUDbt2dh6N4tf+qESYNdWDNj08UfWKIzgd9XguuZaih9OM+PZTil2aSFC8fvlIosYRDPI6ftxp7dKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706101594; c=relaxed/simple;
	bh=GE6gP1+mjQd3St4WaJdQy1b8W5HnQ9AO2LxSjkD6yIk=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=PRVvGcKVRXg3r3qYOm98RarcMrTDGq3P4CiQnZk/5WeOlfaTXgFQRx/mQAVN8uGaCGgPZJ9hfYusOkxMo+Ayp2Z6kXdXhbrOOeBSZ4YVvL1mjNUmiOcQPhiky5im3/VoLmdcxSgS6CAJ/BnHhbctEc1bKTbu51qqTQiu4dWFo20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=locusrobotics.com; spf=pass smtp.mailfrom=locusrobotics.com; dkim=pass (1024-bit key) header.d=locusrobotics.com header.i=@locusrobotics.com header.b=F38fPzqH; arc=fail smtp.client-ip=40.107.94.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=locusrobotics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=locusrobotics.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVudKYaLvJqGOhTGZefHjdjURCAYhz1guPc6srNxeGqC3+EA4nRzQltYctw2msonguHeHG3r/5kDL4lakBCGAdVGNqLQbxQ6ywW36Lb2Kpe/1WcZAV0GjGGeqBpgT9BidMpWqokw1rMD5uT/esnL2HvNXzG/R+4MVs3F9sVPOi6pdV8qFyL5z5SGOfdMQiiNJSR8VjZuQW8a3VqJRW0wCYAWJ/vg8BxqCp6TtUrKIwc2hqible+2jl7qHI+/kcgp+y0ysH0sYaM2nyUKjlgxibB9+N3QNvkAVAxuir6Kf/lwgviqBdK6TVx4fgSDFU6+w7t9b7UujFDaTifFQP7S+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOl1JxY2nemJ1gLPItVz4g7BN4LuRJIeqYTRODR/USU=;
 b=l1azrkfwTla0TtPsJ47OaY607Ggk9Q8/8KzZ32lK7jAH1gdR6fCLqLhNfj+PxKPcm2tCeCaEAb/ytXPXHV+upFLhFZLt2x85VVN5CtzlksbL1JUCFnlVFiyx2MpiI72/FXSc0y/qrTFssfHsKxsDh+C4d4Ex9Hop+fVOakvRb0SWjVeWQpoUdElSEFBCNOlJ0HIaKEF+B87jGp6Ygu2H2Iyz6sic2ggvHIsHYbLBprHgiXxbHgXjKPSRIJtZpuyq5Uqb46FfxjSBZFg+oWWloWhO6b4fdfyjHSV79nfn+ojulOzRr8IpAgTtnWx1+WJ+9ZfvoWbrQII78mpzfspOKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=locusrobotics.com; dmarc=pass action=none
 header.from=locusrobotics.com; dkim=pass header.d=locusrobotics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=locusrobotics.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOl1JxY2nemJ1gLPItVz4g7BN4LuRJIeqYTRODR/USU=;
 b=F38fPzqHlfGKmQbCQsM7Scx00YVaaBquXVg9fERkSopmdBKhJDJR7nZTllHZprngc3Li56I5OM4Z45pxQLMeCIRRT77zqBFzB/YPQlfPHcM6WXxKHmZtJ73gzy7vHboAZXWpYqLaatFZJWa4Xw7gAXfXaaCxpDkOQdRFb9fM4Lg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=locusrobotics.com;
Received: from BL3PR10MB6163.namprd10.prod.outlook.com (2603:10b6:208:3be::9)
 by PH0PR10MB7062.namprd10.prod.outlook.com (2603:10b6:510:283::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Wed, 24 Jan
 2024 13:06:29 +0000
Received: from BL3PR10MB6163.namprd10.prod.outlook.com
 ([fe80::fa77:414c:bd6f:3bac]) by BL3PR10MB6163.namprd10.prod.outlook.com
 ([fe80::fa77:414c:bd6f:3bac%4]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 13:06:28 +0000
Message-ID: <dcdbd757-ad6e-4fe0-a0c1-fe328431b73b@locusrobotics.com>
Date: Wed, 24 Jan 2024 05:06:26 -0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "open list:MEDIATEK MT76 WIRELESS LAN DRIVER"
 <linux-wireless@vger.kernel.org>, ath11k@lists.infradead.org
From: James Prestwood <jprestwood@locusrobotics.com>
Subject: ath11k multicast action frame RX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAP220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::7) To BL3PR10MB6163.namprd10.prod.outlook.com
 (2603:10b6:208:3be::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR10MB6163:EE_|PH0PR10MB7062:EE_
X-MS-Office365-Filtering-Correlation-Id: 90698d3f-3bf4-4818-f7e2-08dc1cdd4730
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	H73BeGOxKht+xf/sKKTp5tv2LKZ4odI6drx2r6xfKOO/4eDqSpL9fOQd4KxOFvcbV8fnGY3whIKhi4bCALLh7oq4dZviBx3YYh22l0LtcRugnWFdjB3N+VjCI4JYFQdL4G5VuC1m/9n1luBYiIJKbNhWnTZzhSzfkQjJLuuGTmBLlFBI2EglyZjdc1WoSmk0Gl7a0KJEubN/U83RmwYW+yPp7E1fs4JGogQy9Y/IFo3ovozJxvkCiS+RRmotgniJjKzIMxtNBLde2oBRhRDAIGza8jUXFvabocboCEOkIVANXGcrHoFni7ybj0jcSfFTjnDpfIO9RBav6/BSJnbqkk+4dThOTcJUwMnJVimJDA4mZBBWv+BDM724VNPZBz4ILGRecFjXy10U6TZFRw6EmGSKSSdbDrZtKoLlZuCdUycVtrGXBtmpZabTq+XyfsiJOt6mJSeIPBfAmfRZuuh8/3M8fSEiJNWMqgRmi7peYwJa0noSU+bATwLFaLcrtBfjy/MxhUWOofulywU3RCSjkh0nVSjbNS7WQUSxgONPJgLtwdz7VQgqaSPcdOT2csg3M6nxGPHihpGDGqtefjGwJ+0lacaWA4FCQkeIUbWc/SpWOui3E5pMcaD+30Vzu8MHLU2p2y1bSG6w6h8pE0GdrqolKUDbpmKUa8j5dDdRP8oxhoXCy0hHsqS5sAq8sP+K
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR10MB6163.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(39850400004)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(36756003)(8936002)(8676002)(4744005)(2906002)(5660300002)(41300700001)(2616005)(6512007)(6506007)(83380400001)(86362001)(26005)(478600001)(66946007)(6486002)(66556008)(66476007)(316002)(31696002)(38100700002)(31686004)(83323001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OW5UNmxvVTZwQmJua2RsNnVzS3o0cmlQZ1RubGlYTlRUMXBKc2RNdFptb1I3?=
 =?utf-8?B?Wjg5Q2ZYemkxL1VubnNHZXJnU1JRQWlQS0o0REFKN29iY0hhckZnV1VFYUsx?=
 =?utf-8?B?RHYwMmdvcDhOeXF1Z002MUR1UXVTYzl5RG5PaDAvcGJ2NTVyNTRYQ3JIeWYv?=
 =?utf-8?B?eDQvMGZZR0pkYWVTeTNMQUgrQXd0RVhBSW5zUzdPdDBXS3NSS0xkeXNhN0Rz?=
 =?utf-8?B?STdwU0liM1FLSGpkZmpZRk9ReFJBSjJjbmpvTTg2S2Rsb1E4a3k4SzBSbFZ4?=
 =?utf-8?B?T2Q1MmtuOGNFSEFaVVV1aEsyMWxlbWNpLzJxT0c4b1k4c0IyamlLNmFxMk5U?=
 =?utf-8?B?UEJmeFQxOWFlSWgwWGNnNjIxY3YwdVVNTDg2K2NrQU4rM0JkZHNtMVM5VkJj?=
 =?utf-8?B?bW0vdVM1OWZVTTViWmZyVFovbWIydXZWdmZFakhlOEl2OHNNS2g0V082Z0N4?=
 =?utf-8?B?Y1dVdlY0akgxS3dKMDVBSCtIdkY0ZEwyYnVwS2JqMVpuanlLK1JGVXFNZkRO?=
 =?utf-8?B?N0NyQVRYQW91ejR0ZjFXQXl6RWt6ekJvYmhCbGtNdEhDZmg2bkhEMFgxbW9q?=
 =?utf-8?B?dlV1MEFTVHlWdVVIMFlJVE5BcCtGUWNpcGFnU0pTZVY1K0dLWmwyZkVvNkJV?=
 =?utf-8?B?UE9VRGFqN3BxcmxKT0R6NDBjYndnWUdIaGJYMzgyVkVMa1l1REh5Q3VZTzNE?=
 =?utf-8?B?UldrOXBtZklnZDhZUGR2MXA1Z25VOGxDZkdVTGFyUnJNblNPODRXemtzME9n?=
 =?utf-8?B?WEIrRDM1QkE1Vjhtd1QxVm44SzY3SG5XbjhjdXU3NHczWEo4RWRTZ0dBMzRQ?=
 =?utf-8?B?VkVnbWNPbjkxRjJzREcva2RSdHd2L1l0Tnljd3BLT3NJcW5jbEZzN3NMc0dh?=
 =?utf-8?B?WWxsaUtjc2pYd2pKb1VOa1VmZnF2d3d2OW1zaklJVlFoL0gxbG16NVJLa3Fa?=
 =?utf-8?B?MEFHRFpUQWNKUWZzczJ6YzBNZkhUYkNpRHErcnBOaWZUTi9FSVB4NHoraFFt?=
 =?utf-8?B?bTdIdGVSMDBrdzg5Z2t0NDh2VTRpaWQwcTNjUDlpMXdMLzhRMFNrbU1LRDI0?=
 =?utf-8?B?RXcydG5DaXVvS3R4c2MrUU9idytYWWwwSUpFd05XWWJOQXFESjN3ZUNSRm9U?=
 =?utf-8?B?L21aWTJRZEZHcjF1bXhaTFB4NVRQc09QOERNd0plL244dnlKT1FPMUxxcTYx?=
 =?utf-8?B?bHBnUDRmZ3MrVFYydk82blAyZDFoTVdTWWNDZlNkMTlBWTV3WmVMSjAydjlV?=
 =?utf-8?B?MW14ZVFJNUtkbXZ2MUVSYTJtU0NzNFlQRE1vMnNSMHFHMFFMSXNETjVRekdx?=
 =?utf-8?B?YmxGUHZpcGJFRHdva2Y2SkE4RTQ0YVJvMzZHaEhrMWtjZlBEV2xDVTVkeUd6?=
 =?utf-8?B?b0pwa3NLRUlQY29HODFncUJ1d0VPRkhtamZEL3FBMmNlT2M1dEMxNjYvYXNq?=
 =?utf-8?B?Vjg1RTZ4eWFDd3NLZXhLRHNEd25QYkg5alg2RVJEZDlDMzhXVU5zUHVJM2Fx?=
 =?utf-8?B?VjVBY2xKWVNxaTVPWjYvZ1U2TnJtMlduWW0wSlFoN2QrS2hlTDRxcXlOazV0?=
 =?utf-8?B?N3oyT09Hb0MrSUZLMkRnYU1kbmtLY21OaEl0U1A4VzQzMXgxQWlSVStOQXZx?=
 =?utf-8?B?VldSTkl2L3ZmUXBtOVN3aVNIZm9oc3BRcmVOOFliMmtqcnMyWE5Zc1ZKWjRh?=
 =?utf-8?B?Mm9BL1NaNkRteG5ndEVkZU9NSUNMWHIrOEdTbnpsQXhGMGp2M1VZRVdKdjJw?=
 =?utf-8?B?QkZ0VmttR3RYRng5bEVDMUN1ZUFHTWsreEJ4N2YyUHNlbHJZWlB2QkErZ3kr?=
 =?utf-8?B?Sm93RUc0TlBIS09BSmt6WEpxWkFSVU04aEtHRk9YNm1UTkdESmlnbXNxNUtR?=
 =?utf-8?B?a1ZmTThod1NpM3B0NjIwZzlFMERUQXBoekpPSDB2NHRIU0tiQTdqeE1CRzg3?=
 =?utf-8?B?SjBLWjh5dklVSHFva3VVRWtiRjArWGlrc0s4Z2l0ZEViL0VFQ0hDcmVZZnk2?=
 =?utf-8?B?VVVyd2ZtVDgyOWVTOVZIQXo3aithSVV6dDlSaVBjY1IzNXZjQ3N6ZkFsbk1V?=
 =?utf-8?B?TElOM1ZJZHdGeGVqdTJmbHBIMjRoVUF3TW1manpIK0I2UURmeE14QU9SWk4v?=
 =?utf-8?B?RWEzYTlFZUZEbWgvbkdSNjh3bld0ZVRZeUpXSnBtbXlJNC9uV2FmYWxNWUlN?=
 =?utf-8?B?ZHc9PQ==?=
X-OriginatorOrg: locusrobotics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90698d3f-3bf4-4818-f7e2-08dc1cdd4730
X-MS-Exchange-CrossTenant-AuthSource: BL3PR10MB6163.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 13:06:28.8515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 068f275f-67fa-4977-a33b-80fe854a9590
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tklXoHeGJBAS5Hbm7Ck27wtPzWi75zXLOc0TlnR4RNCWfCSsurXCpAldae9j83rqm/Onr6xZ1vTVIsnrkXo6AN/UEuQ018srV4xdlbQIT4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7062

Hi,

I recently added support to ath10k, for the QCA6174, to receive 
multicast action frames in order to support DPP. I'm trying to do this 
for the ath11k QCNFA765/WCN6855. I took the same approach as ath10k 
which was actually quite simple but I'm unable to see any multicast 
frames coming over even when I enable RX/DATA debugging.

What I've done so far is:

  - Add FIF_MCAST_ACTION to the supported filters list

  - Created/started a monitor vdev from within 
ath11k_mac_op_configure_filter()

     ath11k_mac_monitor_vdev_create(ar);

     ath11k_mac_monitor_start(ar);

- Also tried adding

     ath11k_mac_config_mon_status_default(ar, true);

I can successfully create/start the monitor vdev. I see now as I'm 
writing this email that my specific hardware does not support monitor 
mode outright... Is this a dead end or is there hope with purely driver 
changes? or is it some filtering at the firmware level preventing this?

Thanks,

James


