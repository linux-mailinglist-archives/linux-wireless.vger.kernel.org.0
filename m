Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247A1758E18
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jul 2023 08:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjGSGsV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Jul 2023 02:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjGSGsU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Jul 2023 02:48:20 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2052.outbound.protection.outlook.com [40.107.7.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B231BFC
        for <linux-wireless@vger.kernel.org>; Tue, 18 Jul 2023 23:48:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnccj3vajCyKbAjE57m6J6qDO8Ajd7zEWhfk3Zu9ACBwQNSmiGKe6SoGgag8KtEbBOXJwJG3Yr7gxsoqZlRuhe1lE875jtbxoVhTMy+xYlgjj3kphLc0M+cJ655OZNAmSIkf+yFpFMcZE+jGLcaJAME3k4ZsJL/dOZgcOrbvCP83wucnxvOvSrmZ7QAjiB61W+hka35HLKYHX6a3IuHVxfG54XKelIpooibJLcIP09YF5fDnletenfkouT/cr2o7HMrFkHLfvwYFTegGYIi+aWIZdG2Czhun1Dke3EFWjzfp2EWi36cNbt31yBbuIB3ECcnHfQd5pfuvY5rCA0ceog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87hoOUKrERrXKFYfuVQhHK/v5Lv8Ybu4TlzcZwFSjgc=;
 b=QrzDA0KIhgdirwbi0cXoa2p5BeDJnAgFcGwytkG2zPB9ZoCbepxNw3ZfkFJkBGpCRB9ufypbFFdDBDFciH8q5D3tkYRumU7CiObzplvXu1Lqpj5CaUYZn//iAzV+mJkSgXomzXsidHUxKd/UCPOCaql+AkssM+a2J3D9s8sM71jnHRTxjzPHvC69KpkBMurUWfefqAjh5SGiEX9r+EgG6Uqs4BOXEaBGRjrMyZEAc1VR8ana78uTYmaxykl/xCLejroK5LjlfK7QS0+vpd4g96gwX0jlL8dMeKkFiGES2IJsmLlo3A/bbvkKyE9qcaVde6iHDAD3uo5sVNXlbXF1yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.183.173.212) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=macqel.be; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=macq.eu; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=macq.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87hoOUKrERrXKFYfuVQhHK/v5Lv8Ybu4TlzcZwFSjgc=;
 b=Mt7IifLeNMd80xqln6v1RDeFpa+96nqoFFdxOQrizKN7h4wTPNkDyNTmpdI5UcqToGYe80QVAu34hTqLkoLvDVcE6VoaOilsnukmuBLVC1bJxDbWtgkItYH8RFFM3NoJdR3bbw5C/fyJRte3yUJnpEFAy3txjjttoKvIlGSzKmFxT738YFF1mkbTZY2M7peQtE74JwATbUW/DiEp3nPXcquo1zhsb4f2oEGrJAY9n5OGD+KplmvmhMnVK01TECfum4PztnfPFdMfmqNm5+nfE2/lAFLgmNbbJXyIMsk8sS0jIwrdgUyzhyXDbktgppCJ87mKAUdTmUrQx2My8PFkPg==
Received: from AM7PR03CA0029.eurprd03.prod.outlook.com (2603:10a6:20b:130::39)
 by AS2PR05MB10056.eurprd05.prod.outlook.com (2603:10a6:20b:5fd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Wed, 19 Jul
 2023 06:48:12 +0000
Received: from AM0EUR02FT025.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:130:cafe::61) by AM7PR03CA0029.outlook.office365.com
 (2603:10a6:20b:130::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Wed, 19 Jul 2023 06:48:12 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 91.183.173.212) smtp.mailfrom=macqel.be; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=macq.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 macqel.be discourages use of 91.183.173.212 as permitted sender)
Received: from frolo.macqel.be (91.183.173.212) by
 AM0EUR02FT025.mail.protection.outlook.com (10.13.54.65) with Microsoft SMTP
 Server id 15.20.6609.24 via Frontend Transport; Wed, 19 Jul 2023 06:48:12
 +0000
Received: by frolo.macqel.be (Postfix, from userid 1000)
        id 51AADDF00B2; Wed, 19 Jul 2023 08:48:12 +0200 (CEST)
Date:   Wed, 19 Jul 2023 08:48:12 +0200
From:   Philippe De Muyter <phdm@macq.eu>
To:     linuxlovemin@yonsei.ac.kr, gregkh@linuxfoundation.org,
        linux-wireless@vger.kernel.org
Subject: linux-stable v4.9.337 brcmfmac compilation error
Message-ID: <20230719064812.GA29927@frolo.corp.macq.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.16 (2007-06-09)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0EUR02FT025:EE_|AS2PR05MB10056:EE_
X-MS-Office365-Filtering-Correlation-Id: 279d3371-2e5c-4c36-2c92-08db88241f20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 37juewoCdoYWDrmTGRvqWK0kTHDkyw0wHH775TGh0cR/HgcT29zsXsIw6bddAC9CIIzFE+CKYwT1c15mgTp8HM2trMYGqdYRuYMdXCcYiSuj0FVIPsVeE+9RvxJtoRWNxg2ysVjSBbIw4kP6hLXmm2kw2vlGaPg84znfxH7n7NueWCeFfKcOmJUYbEBK4E3lflpUFc5XCfot6llKIPZ0a9BOIcvkaDMH5dqLB23MNN+QisyACjBZM6y3SibYMoYwOlTcf5DoRwkDYZPL075K9h/JzQTd8UEtYA/If1IQxtxMjmRtujumRU/ySJ2FmCY7Af7YTGXfIuHm5/MeTGyXYyh3oBUe8etq0iXokOYcAx+3Zs2s8kfwgoGDuqRxVwz7X4Ev0GCpOWGBA07euqzZQXFYR3m/AtXTwtOoU+ktYen5FFBDn5XVjTdCWVGpRcaWVwBoyBQcmAI8atsr+hfj645lL2ar0bdFnbK9c5oUGETuY/QfxWYvKJzjYsENLiqcMHaHVQ2Y/qh86qSAt6Mj79T3p/UK0QZzS0Rhhv9UFN52Fl5zEFzQ6WV+0BPcoZdbclSS4aENK1afSioJLJLxBASH7IEBF/hJxpgJoVtDHlYqkKdKzvsyQt/+H42mGrQbx9YkPIHQtYW7/HNdOrr309hh1/h9RyOXlJD9wg5rKMQaSg2ZYMCJ9YxXZ3QKsaS0Uy1tY6Elc+LbkzyYTQp/bnmFzo8boOwdm3kvCvHZz5g4obshVBnBdG0lkPt7sFjd
X-Forefront-Antispam-Report: CIP:91.183.173.212;CTRY:BE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:frolo.macqel.be;PTR:212.173-183-91.adsl-static.isp.belgacom.be;CAT:NONE;SFS:(13230028)(4636009)(346002)(39840400004)(396003)(136003)(376002)(451199021)(82310400008)(46966006)(36840700001)(33656002)(40480700001)(6266002)(83380400001)(1076003)(186003)(336012)(26005)(478600001)(41300700001)(8676002)(2906002)(8936002)(70206006)(70586007)(36860700001)(316002)(42186006)(5660300002)(47076005)(81166007)(356005)(75936004)(14776008);DIR:OUT;SFP:1101;
X-OriginatorOrg: macq.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 06:48:12.4990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 279d3371-2e5c-4c36-2c92-08db88241f20
X-MS-Exchange-CrossTenant-Id: 5541087b-384c-4066-992a-42aa5fe171eb
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5541087b-384c-4066-992a-42aa5fe171eb;Ip=[91.183.173.212];Helo=[frolo.macqel.be]
X-MS-Exchange-CrossTenant-AuthSource: AM0EUR02FT025.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR05MB10056
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

compilation of the brcmfmac driver in linux-4.9.y (tag v4.9.337) fails with

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c: In function ‘brcmf_fw_map_chip_to_name’:
 include/linux/stddef.h:7:14: error: return makes integer from pointer without a cast [-Werror=int-conversion]
  #define NULL ((void *)0)
               ^
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:577:10: note: in expansion of macro ‘NULL’
    return NULL;
           ^~~~
 cc1: all warnings being treated as errors

This is caused by commit 1db036d13e10809943c2dce553e2fa7fc9c6cd80
 wifi: brcmfmac: Fix potential shift-out-of-bounds in brcmf_fw_alloc_request()

    [ Upstream commit 81d17f6f3331f03c8eafdacea68ab773426c1e3c ]

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
index 33a7378..6675de1 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
@@ -572,6 +572,11 @@ int brcmf_fw_map_chip_to_name(u32 chip, u32 chiprev,
        u32 i;
        char end;

+       if (chiprev >= BITS_PER_TYPE(u32)) {
+               brcmf_err("Invalid chip revision %u\n", chiprev);
+               return NULL;
+       }
+
        for (i = 0; i < table_size; i++) {
                if (mapping_table[i].chipid == chip &&
                    mapping_table[i].revmask & BIT(chiprev))

The problem is that in the upstream commit, the patch is applied to
brcmf_fw_alloc_request(), which returns a pointer, while in v4.9.337
it is applied to brcmf_fw_map_chip_to_name() which returns 'int'.

Should we simply revert that patch, or rather add the missing
intermediate patches ?

Best regards

Philippe

-- 
Philippe De Muyter +32 2 6101532 Macq SA rue de l'Aeronef 2 B-1140 Bruxelles
