Return-Path: <linux-wireless+bounces-208-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 693C47FD22D
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 10:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B2B0B21D70
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 09:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FBD18AFA;
	Wed, 29 Nov 2023 09:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1dGHcVWF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6591C2128;
	Wed, 29 Nov 2023 01:15:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXuzmrGRYTl7IP+YQ66/6pRGCiboNLnUVpiNfKoNxn5scLmTuC+1s+lSDn85Ti/IrWc1k23o8Ww4h4EGTP9Dvy1w11cLgL++EIcfhgk/EJW7HXq1WBioT/0amJON0cHUDNbmWUfLga+KpsThPZmvQBMdwFk3XQiSUCnoVRUtWWl4aGX1J8jYTt77N0J72gE31dQ3HxutgFrk7jbDgPdylfAuCAbRa/opu/Hzsl47stCNdnob22lBntRM+hoddNRQrUxlN5sS6IZkz5lNDAw0bOQDWo8xoLOHd1ECz+zQlGOi0zl1E4b2hWl+/y49w8f5jll4gXrJ8Sdc0fIpsjLwvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FG/v7ogyS6xo4c1TLYkdS7kjTNds9VBLaPwExQZrCs=;
 b=e53e3lEKYBVSAsXrAu+26wPxhnbXsfj4B6fP8GIJ+ZgCFkf2jetrJJlmMUrEMvV9jCVYUaH0ivY3hmeu6OYX3D6FM4pwnKXhg//5to3jGqf9Fsw7JRN2aCtqLe0w0nm+wacMWXHtFG8RyZzIzEb9T7C8f1sK+RWGHqi/QhUxRBjL+O88WyTruMSM/2N7e19uGQrbS6AX0eeK03ddF0uzb9ripknRDK8io3twk4GEeafBWwt+kccIadLHXc/cVH0sr3KfC74HET6d3x/f7iusQMP3SLiK2WG24tFojeLy07jyFNCdBfD17h/osFdjDONcrAAtqRL7BuYO18oDV5GxEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FG/v7ogyS6xo4c1TLYkdS7kjTNds9VBLaPwExQZrCs=;
 b=1dGHcVWFqDHv1m1AE38ElJnELDjpOa2Jy9uJf/1FCKrd0z5sjF5KMxInyy11QqXdwzWO22rzJVsH/5Y6XH8l7k7U5UPhHNAN8pLl5GDetDSkfohfLUtQ+08nJzXAhCd7WMgA//3XS9ALp+5Nw3yXPRCrHHDUFqP5mMeGmV5WLnc=
Received: from MN2PR15CA0008.namprd15.prod.outlook.com (2603:10b6:208:1b4::21)
 by LV3PR12MB9401.namprd12.prod.outlook.com (2603:10b6:408:21c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 09:15:10 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:1b4:cafe::2d) by MN2PR15CA0008.outlook.office365.com
 (2603:10b6:208:1b4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.24 via Frontend
 Transport; Wed, 29 Nov 2023 09:15:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 09:15:10 +0000
Received: from compile-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 03:15:04 -0600
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lenb@kernel.org>, <hdegoede@redhat.com>,
	<johannes@sipsolutions.net>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <alexander.deucher@amd.com>,
	<Lijo.Lazar@amd.com>, <mario.limonciello@amd.com>, <netdev@vger.kernel.org>,
	<linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>
CC: <majun@amd.com>, Evan Quan <quanliangl@hotmail.com>, Ma Jun
	<Jun.Ma2@amd.com>
Subject: [PATCH v14 9/9] drm/amd/pm: enable Wifi RFI mitigation feature support for SMU13.0.7
Date: Wed, 29 Nov 2023 17:13:48 +0800
Message-ID: <20231129091348.3972539-10-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129091348.3972539-1-Jun.Ma2@amd.com>
References: <20231129091348.3972539-1-Jun.Ma2@amd.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|LV3PR12MB9401:EE_
X-MS-Office365-Filtering-Correlation-Id: d0fc49ef-0bad-41c6-cc74-08dbf0bbafcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AgRmZ8hC+ZuwEjzVvo+/PcGzlA8VquqnvEMbOiaVqTa4MaF8KIykKcCX7h5pHEd5jjpEtAKIvM5AfxzwKtoWJeljj/4aZV/HOiEyFaGwGgc7XwieL1NwbYnbilNn8mPv901iac9AqEJ5wRUDXxzTX0XRZralobocPhkRPKh/b0optOeKalRtvLe2FC2+yafIcfh+vGU5CQu5DUNUYPbl0wEMa23BSRjhYZAA70sXO41IVduty86sANBs5cTVEf3oN+KJUkv1CBwI3MCxtmIXODo+Bt874L8FZMo/4zc0Ji5Y3u0MM8SC4fWg/73Lc43Jd+Vda59QcJuLgyAyJAP82MXBkBYfVWoby2KpUsA0+rvQCylQaFMYIUXrqq7V4d59TAfU6dvFiBKp/hRxljrHje2mR0zxhtbqHA5kz2B6V57bAda17R688td1q47KaRRaMFq+K4nboomcBOwnYQVg1Ifdl9hIc+qE9QSDCdqlI80JZ3M60LmqMhaTFMYnoGSp0KrnPtTvgD3sznt+9KeBBknN+alIoy/oXIb0F0mUEprP6Z2Mxurq1nL4vOWRUPbUc+r3Yt4DlZQjZ33NUzRRhQigra4aLLVRaWaSukzDmktTAfdANYG5shZcQ8kKYIygOdP9M85oD/+UmSOJsp3Htgl0EPo1K3w4m6zkgWNX5/5SlCTUfjWhXCmptZfSztPF2jrmUOmOpGPYZuQNbhcoh5cvSLZtIH/SwgpmJQSykXRdXCnAtYzTvk1yShSvPpBQ+H6Dq250KPpOtplTpy35/YOBuFKh9QvaxDWfTDqXPpnvGxNrLKFtf696sV2pBXuM9hXXFyOgxMMH007nM5usYw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(230173577357003)(230922051799003)(230273577357003)(451199024)(1800799012)(64100799003)(186009)(82310400011)(40470700004)(36840700001)(40480700001)(2616005)(426003)(45080400002)(16526019)(1076003)(478600001)(26005)(336012)(40460700003)(6666004)(356005)(82740400003)(81166007)(921008)(36756003)(86362001)(41300700001)(7416002)(2906002)(5660300002)(83380400001)(32650700002)(7696005)(36860700001)(316002)(54906003)(4326008)(8676002)(70586007)(70206006)(110136005)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 09:15:10.1507
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0fc49ef-0bad-41c6-cc74-08dbf0bbafcb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9401

From: Evan Quan <quanliangl@hotmail.com>

Fulfill the SMU13.0.7 support for Wifi RFI mitigation feature.

Signed-off-by: Evan Quan <quanliangl@hotmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
--
v10->v11:
  - downgrade the prompt level on message failure(Lijo)
v13:
 - Fix the format issue (IIpo Jarvinen)
 - Remove duplicate code (IIpo Jarvinen)
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c    | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 81eafed76045..eb507cbf5c3d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -140,6 +140,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_7_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(AllowGpo,			PPSMC_MSG_SetGpoAllow,           0),
 	MSG_MAP(GetPptLimit,			PPSMC_MSG_GetPptLimit,                 0),
 	MSG_MAP(NotifyPowerSource,		PPSMC_MSG_NotifyPowerSource,           0),
+	MSG_MAP(EnableUCLKShadow,		PPSMC_MSG_EnableUCLKShadow,            0),
 };
 
 static struct cmn2asic_mapping smu_v13_0_7_clk_map[SMU_CLK_COUNT] = {
@@ -222,6 +223,7 @@ static struct cmn2asic_mapping smu_v13_0_7_table_map[SMU_TABLE_COUNT] = {
 	TAB_MAP(ACTIVITY_MONITOR_COEFF),
 	[SMU_TABLE_COMBO_PPTABLE] = {1, TABLE_COMBO_PPTABLE},
 	TAB_MAP(OVERDRIVE),
+	TAB_MAP(WIFIBAND),
 };
 
 static struct cmn2asic_mapping smu_v13_0_7_pwr_src_map[SMU_POWER_SOURCE_COUNT] = {
@@ -512,6 +514,9 @@ static int smu_v13_0_7_tables_init(struct smu_context *smu)
 		       AMDGPU_GEM_DOMAIN_VRAM);
 	SMU_TABLE_INIT(tables, SMU_TABLE_COMBO_PPTABLE, MP0_MP1_DATA_REGION_SIZE_COMBOPPTABLE,
 			PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
+	SMU_TABLE_INIT(tables, SMU_TABLE_WIFIBAND,
+		       sizeof(WifiBandEntryTable_t), PAGE_SIZE,
+		       AMDGPU_GEM_DOMAIN_VRAM);
 
 	smu_table->metrics_table = kzalloc(sizeof(SmuMetricsExternal_t), GFP_KERNEL);
 	if (!smu_table->metrics_table)
@@ -2567,6 +2572,11 @@ static int smu_v13_0_7_set_df_cstate(struct smu_context *smu,
 					       NULL);
 }
 
+static bool smu_v13_0_7_wbrf_support_check(struct smu_context *smu)
+{
+	return smu->smc_fw_version > 0x00524600;
+}
+
 static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.get_allowed_feature_mask = smu_v13_0_7_get_allowed_feature_mask,
 	.set_default_dpm_table = smu_v13_0_7_set_default_dpm_table,
@@ -2635,6 +2645,9 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.set_mp1_state = smu_v13_0_7_set_mp1_state,
 	.set_df_cstate = smu_v13_0_7_set_df_cstate,
 	.gpo_control = smu_v13_0_gpo_control,
+	.is_asic_wbrf_supported = smu_v13_0_7_wbrf_support_check,
+	.enable_uclk_shadow = smu_v13_0_enable_uclk_shadow,
+	.set_wbrf_exclusion_ranges = smu_v13_0_set_wbrf_exclusion_ranges,
 };
 
 void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)
-- 
2.34.1


