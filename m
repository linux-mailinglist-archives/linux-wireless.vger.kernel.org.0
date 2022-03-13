Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2D44D7825
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Mar 2022 21:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbiCMUMZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Mar 2022 16:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiCMUMY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Mar 2022 16:12:24 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2060.outbound.protection.outlook.com [40.92.90.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6BD4FC61
        for <linux-wireless@vger.kernel.org>; Sun, 13 Mar 2022 13:11:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WyZQm+PK3dTzf536EuhWk1xAkR/oVL5clNiIBGb4kaaIg2Iud/4oXqIgLB9+mv1PO+2t1LB4TLAoAcjgn+jgzhOqrsV+AkB9bEjE8RPZ0UBJYdXTz4LXxkXQXFYuSseg4w3khG0Nrsw7isuc0i+a6q7+zdzGc4ssFqMPxb0KJrDD11l0PkJwR+KDYMWiMg1D7bIxkqEEh+/nBmarEBkyp2JqlqyDnm2WmPQa6e91PNRXOWb+fuhr/0F6mW7MrzDtZmEWR4tMp5CZtMmbBC/73fYLzbF/VfLqxxJNMTa0otzxXQGpNnCz3yuhZM7neCqGuwm+0Fqsry/s0iPJBhIJCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SgiHTlws8/O9mJEAp2ti6sahJLrV7SXb/lryrT5U9o=;
 b=JLycc7mQ08dzmQKKxnIBvCsM7kIPcbacAi0J6IhM91MspK3fzsNR7SklXsEpakSdePPaD6jPwXfCKRN67DH78HUUdBg4CVqfE1JlfBi5lfoUydM5x0aFRoPYgPBRiOLa5krSZLlZaMkyliasO6ZZKSSjJiesOzxwBOJT3L7aJd2MsKjGbW/oT7EzdbL4/5qPe3eMy1jkDAF0ZUMiWYKPZ8le34HdnMz8+t6YV4eV4V0cen3Rb5KMrVfwMjIt1nxbBMwf4f6LQSxYxw788aThZgD+R15TtRMLu5+WVQbJEud8DPrcYcngBHWCNcVCjxwg7m5Lur/GDTz1VAzgqiH8ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SgiHTlws8/O9mJEAp2ti6sahJLrV7SXb/lryrT5U9o=;
 b=cDQwgXomdcKx21HosLPbj+TsyW0YMhZziMo1VwN98Hf/q6zaJWZXmfxzEAzj+MZ5rlo0AroLYZZA1TRFc2tpy25bK3FvTD6Pngf1jtNDjDj8urEbrhevoplt4u4GxVINWwSKrYrw72COtq7FxDXmLkqTHu7ghnhbd/ImQ5izazaBZjtQaombXQ6F8jn67JDdsEbj8sfu4YFOQF3mSItxUETD0gwtG87YR0TCs29zmQeRcs8n6BGxwwftaWqw+MOoztKzgFSO/FkdMrOKZZHrLw8aqD3G4nE3t9dXiRelUdHpL9LLS2ATlF6IVoJgiWuxaQR0UqRhHHVeJIBUdaRJsQ==
Received: from DBAPR04MB7366.eurprd04.prod.outlook.com (2603:10a6:10:1a0::23)
 by DB7PR04MB3964.eurprd04.prod.outlook.com (2603:10a6:5:17::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Sun, 13 Mar
 2022 20:11:13 +0000
Received: from DBAPR04MB7366.eurprd04.prod.outlook.com
 ([fe80::cde2:76e6:f208:6d18]) by DBAPR04MB7366.eurprd04.prod.outlook.com
 ([fe80::cde2:76e6:f208:6d18%6]) with mapi id 15.20.5061.026; Sun, 13 Mar 2022
 20:11:13 +0000
From:   Jonathan Teh <jonathan.teh@outlook.com>
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@kernel.org>, Ping-Ke Shih <pkshih@realtek.com>,
        Jonathan Teh <jonathan.teh@outlook.com>
Subject: [PATCH] rtlwifi: rtl8192cu: Add On Networks N150
Date:   Sun, 13 Mar 2022 20:10:55 +0000
Message-ID: <DBAPR04MB7366E8014ECA839E1F5CCE29920E9@DBAPR04MB7366.eurprd04.prod.outlook.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [idcukU5tyMm3vsOiA69yoTZQ5wiQpojm]
X-ClientProxiedBy: LO2P265CA0122.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::14) To DBAPR04MB7366.eurprd04.prod.outlook.com
 (2603:10a6:10:1a0::23)
X-Microsoft-Original-Message-ID: <20220313201055.15349-1-jonathan.teh@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfc10091-4259-4958-562c-08da052d9f67
X-MS-Exchange-SLBlob-MailProps: tBYDyRQCPclfnH/0UAfOFg3VcfzM92AUhVehPY5jh4TQjSfdvY1mp+wpMVuSmMe1GA8HYtW1FDkOzED3vmCALPrFbTKAEbv4iJLurlOncJhtz4wIV35NKGkF5Kiob5sCCXlM2M5gQ5f+zZYP6mgdYU79iOStq0KP59o8CU1Us1di2RbxoXIAmeFpaSLiPcp7XTCwo4uOsgQBxC7fnnFHA0TWawfG3W1DNHISe3uWtazUAxy8CVKwdHap1fv6GRm592BPXPdUsDLUqseZUuX37/BP+ykh0QlPhrPiyWy8L0KaSwe9dLS+jUciHLKL+JUTrCXysmu+gwMKPQspc5M3nkMdK3Ty6gBzkruValpEjm743JpG934RcCLoOmaeiwO922F/yHXY15pooG5krBAoZtH/pConaQX3m2lup0l5lPg2CQDU1ouFn3iOEDY9kVhN+In2dZ6YXLcJGLqGWwuwAuVNtHmRudAYoyg/zqOA2n+NlyOiRk4CIzywq4gEoA6dAzjS3RcOiYa/3uR8dNa8Ksi6szRsA8U+CSHY7OPp3BpCZFv5zYTVQPsogT8He4g2MjFn2QjLvycnxFeeutXFybnPO4stI3rQAwwGKMMhhmoOzuKoYeYoV1VfUhqlnP2PO71uCC6VdsMv1Vdsk6VcKg+caoq0N5A0vbWzewdl4IYbXFWClBKxLCkDVHhBkk/d/ZzRgXjAhnBNiFqzEh9BKrcsxe2yN/NJTHd22xKDi/8TxS6fpO9AlC9UjKxIJWsvv0Aw2YAGb2k=
X-MS-TrafficTypeDiagnostic: DB7PR04MB3964:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uQwzn7RRH58VFFqGEipJpJrM5lIywJ8owXHcv61xIz7EipdObO2JxxNQtt8U8XNQGnCOynGUGOS+gDK82Ocei2RIH6cMrpNen2DMIWqKh5rH1aEfrXhg0E6sIYB/qq/i4nzatkCh/9ZDzaPiOL33RHTJO8WMGDYlasWrhhVC13MVq6jd8of0Riv0OZ+xR/wTYbilFwZV9UDIPZmbFqK7JBTIkXBdQS1gXtSVK0NE2CiA5oi87k9fJ4LkSCMYGvd19hOC72OfSKE0QOB34OvFBNtBbqY9a3Exd+J8WtAhYH1b4RLkhrplHUe8LhlJx0/ZQ2C+uuJoPbP6kPbv6Np6PYTF3Acsy/WfaYetKUEk7XV/wJPAzgU6Wblzb3oF2zE6Crl/lIX203Y2jkDBGYzm/ZduTC6SC5KTzWD+bdMHFMUrvoUhkFl+qL7yYaJNOii3pxmTxH9jkk1KfOzSxM8fIV9Fy42D82M0+iFyGP0iVkaPIAJCMaFhs6R9d4ARNuytjSHL5v4PRSpkA9ZLeemstlB/T+DciomXPIkNmlPiGptysMdZLPQyFIue7DAsYZQP/iCZvPbBtz2pqC1qd4VAAw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?609+ar7kCD9XPEtybQEjvuifLSEy+BCiXuWfO10Ecp3d/h+ST+dtUXfpPJmz?=
 =?us-ascii?Q?lBvhvTjgv7VQ4/QzusmqvztZR4Xm27oKmYGeNakhaG3RakQ/ydrQyot1tPGr?=
 =?us-ascii?Q?H5MXuOnCsXSkll7Xp47iS1921zQMMadNTIpIetVBIEYPs6Lx34ngVqmbKvXm?=
 =?us-ascii?Q?dkgWHaARWZKkpvJVOiYQfn8BwCKz6N2Zhc/ApYpnvURbnvTjb/Cgov91EkLY?=
 =?us-ascii?Q?Sd775mfuh7F5/cTcrXBWXz8WVHk3Ox/gabKtO21n4E5Iq1zV6A0+xOtrH5Q3?=
 =?us-ascii?Q?Akp3jr6hZTnNBmMxQIWeE3puAvoQvVgmZoRYw+cj/0qbIoDvXRb2HzXciDEs?=
 =?us-ascii?Q?s5EGSxuLq69UUkqcRXjUzGw2ETsKXrpLhUqqjRCIHp6LbJ6EVz3AyqRMwHiT?=
 =?us-ascii?Q?2xr6e+z5JON4pGiXYwDIVvap+Ar9yN2zT29AzQHHAgQkZyaSUKBbm20JpqMB?=
 =?us-ascii?Q?zVORnhc6F+cspCfBqhiGmzvYCutfZwrbpDuCQS0KddhiXzbHGkN9URVpRmhG?=
 =?us-ascii?Q?Jn+BS0ve/eGQ1P/6LC1V48d33/VJiOzmvc4wl8P+kC7MuIKpYE7eOXL3INEW?=
 =?us-ascii?Q?Yv8wQ+g6ueY59qhyNAP7T67nV51EsVgg6ZlYNRRBXTPAn7Tp+ih9OJ/nyinM?=
 =?us-ascii?Q?ojRMO+ogq5T1ZQh/FT62MlWyYIVX0AVB+ruh5UkNlImPbZecsB3LDESjcsZD?=
 =?us-ascii?Q?Vs0pjxOBFgnnDABaekNKw4u0LEWkPzW1U85IutAa235xgc4L3AVJUZp55/vs?=
 =?us-ascii?Q?RKZoYhTtCXo8YQLWQtQOUtSTMvUunbfe+z/tOLm52g8PmvMVSWpw0BWJRfbu?=
 =?us-ascii?Q?5/CvlrYTiF1gddvvLOpOinIr90ztt9R7ZPrhOFqRpA5bUH1hSHRmxGul3bjs?=
 =?us-ascii?Q?b9vY+iF+Rf09DZazKTATg28VPdWTmVCluTANyhTKstrhrL4PFLnHEYrsoUqj?=
 =?us-ascii?Q?MQ+hBqP0VwBmsaSDjVACdQW8BceeFRgYWAcAslLFhnA9Q5dxYZmk8vaRt1Bm?=
 =?us-ascii?Q?RfPvbnDHQ9IutiTJ3m2rv8kmnpYRzyXAn/1Lw8mgpu8gLMtXMGLE65Pgpoxh?=
 =?us-ascii?Q?vbOSvxAePDji2E+mMRpMY58q1pn//HfwHrDQCVhPNfSVcnUqI2dNn5NWCCcU?=
 =?us-ascii?Q?0ta7Ilm6xl1qKjBs2KDzQoe69MNB169PmA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc10091-4259-4958-562c-08da052d9f67
X-MS-Exchange-CrossTenant-AuthSource: DBAPR04MB7366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2022 20:11:13.4237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB3964
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is an RTL8188CUS device, identifies as model N150MA-199WWS.

Signed-off-by: Jonathan Teh <jonathan.teh@outlook.com>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
index b53daf1b29f7..876c14d46c2f 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
@@ -334,6 +334,7 @@ static const struct usb_device_id rtl8192c_usb_ids[] = {
 	{RTL_USB_DEVICE(0x04f2, 0xaff7, rtl92cu_hal_cfg)}, /*Xavi*/
 	{RTL_USB_DEVICE(0x04f2, 0xaff9, rtl92cu_hal_cfg)}, /*Xavi*/
 	{RTL_USB_DEVICE(0x04f2, 0xaffa, rtl92cu_hal_cfg)}, /*Xavi*/
+	{RTL_USB_DEVICE(0x0846, 0x9042, rtl92cu_hal_cfg)}, /*On Netwrks N150MA*/
 
 	/****** 8188CUS Slim Combo ********/
 	{RTL_USB_DEVICE(0x04f2, 0xaff8, rtl92cu_hal_cfg)}, /*Xavi*/
-- 
2.35.1

