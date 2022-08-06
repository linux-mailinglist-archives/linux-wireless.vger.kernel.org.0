Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4F358B400
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Aug 2022 08:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239369AbiHFGG0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 6 Aug 2022 02:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiHFGGZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 6 Aug 2022 02:06:25 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CB220190
        for <linux-wireless@vger.kernel.org>; Fri,  5 Aug 2022 23:06:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JagM/h/dXXH9nSgPW8a6ZpiVJPIqLKl9tAdZ0XjJOarcxVFnR4HNeW/Qo3XuV8y4ro1hxWjtSvM07sWBswrH9ROvtO96Z1w4lFGImHV4XV3RICLZMACMlAmcWhji8qgZI7XW5p5dJW5EcFRJG6vdUiFHhatAmKquOZqu+h8mdVFRroG53uduUn6RcgN0gmVgp+bmx70Y3P+nXi2HwLJ1ck01qwbRLolHKXm2U81ZTtLtp2Fdd4KIzpiPawC+oEEp/VPsvuS4DG6skdvrQrWRPxwrjeeIVdcweB1tg2JlivaJ2G2fYcm5lRv1XN5Go2bkRXzxkoD6IFO31dyT1DllxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01X6oVwaqRuVce2YAbvWxxfL2Xvj1K6+BVuQYFw59lY=;
 b=A//LvjqeSvfTSnmgFMmVj8Q4Ci/brIekWh1sA5+PFdjfwVWXgt1sruVhldthchFD7dvfDgwrRYJor86kSDzwbDtZxNwAWEMb82vp+Dsk+P/KWEXPrIyNgM1N+fkMpyJZ8RvRysbDtXbvWM/G458GKO3D7fNNOAPifn6f1I4n7QZ4GnpOfbkQNpPJ1OSpDoxnsmYXeDNCvSlA1rHa0ZDlmnwyDYFcoQdzrg00yVAenBWIECLPCXhjCyHeP5i1WkViP+k07RXYI81lgVBp7dXAKMqTZmoI2QWXJzXfkzmVj916c6oT6n1YDasA4aL0R6cpltODHMAG7p5/eymNtk4hyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.136.252.176) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=stryker.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=stryker.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stryker.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01X6oVwaqRuVce2YAbvWxxfL2Xvj1K6+BVuQYFw59lY=;
 b=ctrmM4HPakBIkGJzWlOvw87WAU7qIFeI5jYVn73ObQ6sHYWUdrhvyhHf2y7HYP49J8AtFhjP2/o3GKMPTIjJEC0tzEB8geO8ZDu3o0Jh0ZQx64uU3kXXUQ4wzoQwcdky8q9kYjEw8rp0LOFwNfzG419KeEqvdrDWQV+0EBl6uiRAwHmR+A9D1unJ33055ivMw7ut7GAj7s6sYw+BJEPEp5fiKTsg7lQteLFraDu3biDKYl/9gmaTYL6dnjWwVzWQ1gwBkCkZ4Gw2vBymgwpGI86UmUDdt/G5/8IPwJcHcj9t1rW5YWbN4EhOg/JYwZd4/NVFTRarjY0Y7kXmLPmOqw==
Received: from BN9PR03CA0985.namprd03.prod.outlook.com (2603:10b6:408:109::30)
 by CH0PR01MB6921.prod.exchangelabs.com (2603:10b6:610:102::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.15; Sat, 6 Aug 2022 06:06:21 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::95) by BN9PR03CA0985.outlook.office365.com
 (2603:10b6:408:109::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Sat, 6 Aug 2022 06:06:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.136.252.176)
 smtp.mailfrom=stryker.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=stryker.com;
Received-SPF: Pass (protection.outlook.com: domain of stryker.com designates
 64.136.252.176 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.136.252.176; helo=kzoex10b.strykercorp.com; pr=C
Received: from kzoex10b.strykercorp.com (64.136.252.176) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5504.14 via Frontend Transport; Sat, 6 Aug 2022 06:06:21 +0000
Received: from bldsmtp01.strykercorp.com (10.50.110.114) by
 kzoex10b.strykercorp.com (10.60.0.53) with Microsoft SMTP Server id
 14.3.498.0; Sat, 6 Aug 2022 02:06:12 -0400
Received: from bldwoapp11 ([192.168.131.10]) by bldsmtp01.strykercorp.com with
 Microsoft SMTPSVC(8.5.9600.16384);      Sat, 6 Aug 2022 00:06:05 -0600
MIME-Version: 1.0
From:   <noreply@stryker.com>
To:     <wos@stryker.com>
CC:     <linux-wireless@vger.kernel.org>
Date:   Sat, 6 Aug 2022 14:06:05 +0800
Subject: THE WORLD FINANCIAL CRISIS CAN MAKE YOU RICH!
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Message-ID: <BLDSMTP01cXIW6Jm3pH0011b727@bldsmtp01.strykercorp.com>
X-OriginalArrivalTime: 06 Aug 2022 06:06:05.0260 (UTC) FILETIME=[9CF0B0C0:01D8A95A]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa85704c-c905-4188-7c90-08da7771c935
X-MS-TrafficTypeDiagnostic: CH0PR01MB6921:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FcwOZ4wDX+iXG2NWweknRDKswIA9pKN4LtFwCHb40k/EsXBX0Cif4JG94J/84NKk3yV2dmkyZSrwduAcF75t4PJpfr0KtgGgBcngNIUfUXheMWKrsSnK4I6XZ4apGGT7kb7Izq1rK/fSClTzb6/x4NDp4E8EoP85Oo5yr7R8W/vg7hMRFUzHhS+yjg52BZhtsM9IUmLjHxlyoLE1BvyWQ7b0BztsuVaRw9P7eOZsRy7uybOVopgpEKIQiyuLpc+kyvyLBpVBGpaLTVt6fXYZzG7ImX4Gxt5GAHKqS/jW5YML7AAyezQwUEcc/zd++Iz1pMOfAlER5+rTHS7DUDyCknoNchIdatiXSKjKqnqE4/XFIq5M9YBis6ciXqUCmDJembXB1QmMcQGJnr9OruMqEe2xVGvbMfR2JCLJMryxkuLg2OOxRpw2Kf3AmZnnSQ3PQCZVQoxxMlk70LHR0lWGNEVZEHAGrTnEH/E1QkrGWt6SsWJy3vy3l9foE8LpOhDwegxmjscdoSstbPVE1cbrWke2r7X4sqYiinDfQIRO7uSruzVsZ43YZR2JGQjEI/ALzv2N4PzU0qUimwQAUrZFmZAeOrwAjqj8lHvTLjOGvSn/0pILAZWCPXvdzNhpiewXtRGjrR6HpPklBIq6+91w19QVuevfEftbOJ3a5aPmMABu3tt9y8Y4U2eAd1RTqU+27tJeWOSKYi5V5ahE41eXS2RNqRo4tA/umGllINq5dC7ee5EYSZ9xx3oTOXisUOrvC0FmvMMmSDziHvKRDOCP2i95FhJfG6nDTVxw24UL7xELRh8sS5jryBYrVWXa+QPT
X-Forefront-Antispam-Report: CIP:64.136.252.176;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:kzoex10b.strykercorp.com;PTR:ip176-252-136-64.static.ctstelecom.net;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(396003)(39860400002)(376002)(36840700001)(46966006)(40470700004)(82310400005)(41300700001)(70206006)(70586007)(4326008)(8676002)(36860700001)(2876002)(6862004)(8936002)(478600001)(966005)(5660300002)(40460700003)(2906002)(558084003)(82740400003)(86362001)(81166007)(356005)(6636002)(316002)(336012)(47076005)(186003)(9686003)(26005)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: stryker.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2022 06:06:21.5363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa85704c-c905-4188-7c90-08da7771c935
X-MS-Exchange-CrossTenant-Id: 4e9dbbfb-394a-4583-8810-53f81f819e3b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4e9dbbfb-394a-4583-8810-53f81f819e3b;Ip=[64.136.252.176];Helo=[kzoex10b.strykercorp.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB6921
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

INVEST TODAY AND BECOME THE NEXT BILLIONAIRE... https://telegra.ph/Cryptocu=
rrency-makes-people-millionaires-at-15-people-per-hour---Page-567190-08-02

Follow this link to read our Privacy Statement<https://www.stryker.com/cont=
ent/stryker/gb/en/legal/global-policy-statement.html/>
