Return-Path: <linux-wireless+bounces-27428-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3942B7FFEF
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 16:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19CCA7B0C73
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 07:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32A528B4FA;
	Wed, 17 Sep 2025 07:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="ZgJvFfgR";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="VA3e6ruJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF54C1514F7;
	Wed, 17 Sep 2025 07:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758092700; cv=fail; b=O2Z9HUT0LOegRG9Dr/zNqnjznHxUOZqKmrn5KB0gTiG+15zss/ickyXFzxWVpET0JuVcimLvjfBO9bwYUzxHp/qcajdtl4JujlV74GWIEhkYUOrvprLHeUjGMdpVcaeSpk1YsGtmvwNzmU4yLInuF+tEYWmVVZGgyGZtqxIeT+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758092700; c=relaxed/simple;
	bh=htHAMMindNlX2x8eXbjYmgLRexhBNs7uO3GD8vEDVPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gv6SMz4ktqRdT1W/vK7VNLqdEg3LW1k1O8aAbeuDIURa32fCDI5LYrz5rO6PL5Q+/b0zgFo1MMiit00l/rcygdi7a7lqZVf2KQhj/1DVMfO7zXwT5XiUbVL4MpRLjv0ZrbPEj5hc7YBVuq+uHD2+A+FxqQMtgUBudRst0nBn4Ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=ZgJvFfgR; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=VA3e6ruJ; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58H4t7PF3437884;
	Wed, 17 Sep 2025 09:04:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	u+3wuJlWW4WfI9uAsDl+aDULFZzpAr+PG8OoUz7ArNI=; b=ZgJvFfgRSHg8nQ96
	1XCLNRd4W0pY0VS+GCY8CXfRuCKGmwC14hrlTw+E0M3/VIuEE0MUY+6VSdTcrcqS
	qHUr+PdU53rikFSYQmC0Tk4K8AaphRIHEHvhYgWBsaJtyl380/0uNMSL49oseon9
	ZRNHWrhqFYSxaSacO3rik79cisqfRWASSapcLOKxO1BL1hVJG0Xg7zaN6aBvC8FF
	CLHWUtQF78EVC5rByTJz8CePKfAvSPKM+4jbDWkiWKLUlAmJy9oBQ15A0oRvFGMM
	7f1AzpybB+pNTHS0WEVFTcRL+cYqmqaR11b+ezNCUNd88sgwEuzO3CX8UEttnslg
	OvdWEw==
Received: from eur02-vi1-obe.outbound.protection.outlook.com (mail-vi1eur02on2114.outbound.protection.outlook.com [40.107.241.114])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 496uxd1gaj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 09:04:42 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mBl8L5FT7MHF2gyxhPIz/F135j/jXQEhgFJ/lViOugpdDdlyxkildXQaYh5S31giIcmhofeauPbZzhfEOggz5nLataLtkoquTpj9lfMMGEgGD/B+3HePF2PZz+G3A06obdki+Loa53FvEx7LsAM1pMZaHNcc1MftMkqmL5141U3AfKWh0K0hcEVItgN2dfdCLFggAGrnaPzn6H8/TSzxBVtakV9y4QTrhbeIO4wJoEhXj3RfFkHxwN1z8Zc0IP5ZZHFNXS3k3PJ+Fv3clM0ND5UwoUdctkwzkZhb23VYP9ZVRe7Kc/eEKGWykVSvhZaJHEIzRC7rHuaMOhaVEwmR/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+3wuJlWW4WfI9uAsDl+aDULFZzpAr+PG8OoUz7ArNI=;
 b=oUAieKiBvinor/Dw+Rhfh01T91ZXktuVbH/k1e40aMy1KVV+E5gUHdO54ybbsGUR7vs1FjNSHb/pCap4t3uscbaCUB5iNd8+KKZZJGO/52H8a53efnTK7MC+mFrg40lrsh0dkCnkIUx++Bxb6uDfmZ8/KiBm2xrUJ2gBzyVqpThcQ3wFhNDRtncnYU1M/wDPrgx+azZRCnrXtS6Y90k9xbX3RlrhjP6q34QjYWYqHy78BnonbAsPSn2LZ2m8U6bYChp1IQXSjNJUaU2lvK6PBVLoAhgx+VrYOdLhwwYBCRTQs6kRyR8s3S6aXjDoQ9q0UnmWDUpg/J2T2T9HqUCwEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+3wuJlWW4WfI9uAsDl+aDULFZzpAr+PG8OoUz7ArNI=;
 b=VA3e6ruJCbgcgY/5+Rg7SX1rWG9fS1dhw32A1Iyawl2hJCPIYm0rAB7VkVXt3WOQLpL7Lc8JAFp96xwpBu17fm2DxPQaqkHJoApR5dNKtclCw9g6OD1KCPPNx6VSh373AWEjIX+IqUp/qx9wHazuAJ0rs5OGpYYsmjOAdZbIBFw=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by DU2P192MB2171.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:495::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Wed, 17 Sep
 2025 07:04:41 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 07:04:41 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 RESEND 4/4] wifi: ath12k: enforce CPU-endian format for all QMI messages
Date: Wed, 17 Sep 2025 09:04:27 +0200
Message-ID: <20250917070428.2909-5-alexander.wilhelm@westermo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250917070428.2909-1-alexander.wilhelm@westermo.com>
References: <20250917070428.2909-1-alexander.wilhelm@westermo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVYP280CA0026.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:f9::29) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|DU2P192MB2171:EE_
X-MS-Office365-Filtering-Correlation-Id: 739f43c9-085c-4d53-091c-08ddf5b87933
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FC3FqqPC3rVqiTvTsgIABTrCApzCJTtooJLv9HIyXu8X6ZhfYVIhW324dIOf?=
 =?us-ascii?Q?FsKglkRwZcZgiAsju207pWSR1a8g1nDL1E0R/JpnoYDIAVZ4Z957DhKEW5y3?=
 =?us-ascii?Q?IaUGVQaQjFxc4FOaj/FNbYJIFxvsQxYNHD/0cO4p8fhWMxIlp9ApzH/XRMdV?=
 =?us-ascii?Q?fyGKTBeY1pVjVEgP58/hNQOIxTC1VH08lXTxt7x9JtPrqz+etOfBQpbfomX0?=
 =?us-ascii?Q?f5YQ22P6QbgTIMQfdfVg4Nx4iVHyyUiNGZ2BhJSwkQ+DVvkfrCX+nClW/HFH?=
 =?us-ascii?Q?OkVqsv8yv6aYYJMyN6WbMWUCHav2v7S7FyThqHrmerMJtQvVTpv9dF2km5ze?=
 =?us-ascii?Q?zIfiw65HzZ2xohyay8UW50pzPmGBZ1Z4gqVFAAw38QVY2jQeEPb8QWNqoJiC?=
 =?us-ascii?Q?G3ACqQ26GDMck6fnyNXrjp4ynqQII+oZpdpu8CWZKwahaaytL7XDqHeNb+P+?=
 =?us-ascii?Q?QahkKI15HH0JgdtCACr0ayZFjqXs6lDNfK12pGTuhPGWTOvdDmIDQm/8RgwQ?=
 =?us-ascii?Q?LA5XsKXL4Up5yQ9LijZNbkd45b6SKsEc5cbvK93TdFN6chnyw6aTcY0bBrCh?=
 =?us-ascii?Q?bXDbBveijcy9Sb0Gmo5nwhTT9Z9/8w2CfIzTqENcCpC1IZ6tChjf8VhQ+NnF?=
 =?us-ascii?Q?dlRed/uTxP9Aiu9CI3w5TxLY9ApoJ95tOjiBoE0Mr1fTtxmFa2jeeGf9s4qR?=
 =?us-ascii?Q?JIAu/iqBAVw2V1pQ1XWuRFxevH4W6ffDJ2KdOGNxyiEeQANa2ZOVQrtrRmhY?=
 =?us-ascii?Q?m7vtOmUzilY5i0kntcQjcikR4to+aWuCM9XGqRfqSqgqA74nnoEiojfrkch6?=
 =?us-ascii?Q?0Ks+mrQDxRDNtiebHH7qrIj7naxFRbsC0LJq0ROX6VM36HzGSGPkBItEeidz?=
 =?us-ascii?Q?irl4ZAc+oCMx8cE47Tyc37Tt0S9kTk6lkJTqIV595hXoWxNu+TqmEJCQphIj?=
 =?us-ascii?Q?S2lfileqxBOSO2uhG+7EYG+cMnB6ocWkG0iYc6WzLzA9UtVqq4lL5JZIk9w2?=
 =?us-ascii?Q?bUO4tvx26ThDZu+lk+zulFq4DS6XQwD9caRVJ8JNSQP2rRyxAC7DrQu9fkf7?=
 =?us-ascii?Q?XFGKnz/9eLJCmPp+4fc+aIidY4SKpMveZlRL+iQQque7QvxNh/7FJDKfLlg1?=
 =?us-ascii?Q?LD83cjHKuNua8FxEWBTSa50qHSBexXQr7o+3wnhb6X1EZjB/mfG4JZu1u0ZM?=
 =?us-ascii?Q?GMyYcOREfXfdLgF4Em5RUGJrS/mn0XpjlX3Caj/2dknQS+pdi2vpQ8wpvFNW?=
 =?us-ascii?Q?8FEd0G3RtuKUOLvP+SGF/voAEaYOm2PWB5PqE1yJdLeLuTAm4kpKfeVgtq8e?=
 =?us-ascii?Q?OvxnjK1421oeGR5CuNi/WI6hmNeGnRh/NFZ91CFuhE0M8UrMOHOOHcDeJNLx?=
 =?us-ascii?Q?M2y2EugOLI6y7VWOUXY3IDTeSf/G4RgWvvgTxwWZHo49DjGFAE6cOCPF7XJW?=
 =?us-ascii?Q?7b1ZxlrXExw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EKbI7STZ8kYVvQpI7vizK3bMGGI0v+uGt8C+NNmCt8ecgyNk3Gsqb4AMe3Kc?=
 =?us-ascii?Q?IkPk88GeKcWt+gajkDcJYe2WMJQ6VGB9XQLHOlTZyBmdGkTRyU7YdttNgW4z?=
 =?us-ascii?Q?wvCFsQw8ItLQtTTKQcvtOgqfuI1y2gsvhUmredobECgDh2DT3jeoGKCzFAg+?=
 =?us-ascii?Q?IOTzo2l6QWLvb6k9WhrQZPZwJor84Y0tYYdl42tlvbTHo1oIiCje1z93JzDE?=
 =?us-ascii?Q?Jg75WiYmljR4sjjvCLdaYjYH7LBB8I+uBWu3twRBJnXLQLuUpaAn627ojSKi?=
 =?us-ascii?Q?kFaioJOrDGhmqNqo7QFZy3cF0hmYL1UqEY8Y0R1rkjyzMmRgyfI/vsJsr1Qh?=
 =?us-ascii?Q?NbnNTYpa8yEQKk0TSGf3HMx9axwWw8QJbwdkM49cWBHujKjfDmgakU9iIkA2?=
 =?us-ascii?Q?TM/DxIljGIN5REpaIgRnleAqRFXaLoTd0hF6y2Zt+yDXp4Ude4QzMDzPqwc4?=
 =?us-ascii?Q?St1JFdWBIz77IAC8OL0ai1r24eWSEKGE4ZJ+KB/Eeo1j79pGHOr7xbU54g/1?=
 =?us-ascii?Q?ka+c5yHB0knWYd2X+WGDyvM9s+jWq2wOfgW493EXo9vKLnI+8M92/wnrCdsT?=
 =?us-ascii?Q?u3NJHxAsMS3kNPDGi4t6BRh+IM5/9PAV2sbare3Cp+HZI40cWzXDYg0ClpQP?=
 =?us-ascii?Q?KEw0CKcqOnT3pLRSWLZcwcAAgM6VEQcM2Mq7/WmjGkwmxrc1CNjYHCOx1YEZ?=
 =?us-ascii?Q?qQTPTVBA6Zj5CkTQwOd02qhd3DGH1zueiJoqlYXXgLOF3nOiPT+Fe6uxgrNd?=
 =?us-ascii?Q?ixtoO4gdHVcyb6WB8UtGnIAVnbANqJ36KwJPB78DxGF9/WVnEAmGrNAba42e?=
 =?us-ascii?Q?iCWbF04nK2lrzioFMs1z+0lJIp1rEmTzoifl8P+/lKM1j4PYa1XtVlYLy7Bo?=
 =?us-ascii?Q?deI0b+LtLzsEIQs/iwa6hxT7oskXhigGO8dpflduDagRh6EU+fud8EpEMXdM?=
 =?us-ascii?Q?rqpJf5I+LXW+d8G/0nOi09WweRqir+4/pgARiFJBrR32J4yLEwWU9hnV4Ojy?=
 =?us-ascii?Q?h9JknjnWQkDlqb9o9QpeYE3HUnKi+thfQMD39S+2jJThy0Soze2FPPiZ1vEK?=
 =?us-ascii?Q?vyMlYBXCWriFh+kksJNA/T3S9f3knGiAmN8TVYlEjFM2e5aa94CF5Rif/uJJ?=
 =?us-ascii?Q?Yz0CX+hIbQEsWh87N6HkiMVpOhx+frSpFwa5HrvxNayHLaOSXI/gxMVXXuUm?=
 =?us-ascii?Q?4HUhoTNIWnI/+Hd6wRGOWeWQOpINQ9gSC9Vw7yUwurJ6rupFkBMv8g7EoRgv?=
 =?us-ascii?Q?Og2qHuPfRuq4nivE0aUdU+5Om6CdU05qrQvBLIabJOG+rAsUDzcyEeCVOrkT?=
 =?us-ascii?Q?cYmiLZimg72CDfPS6Ka9t8duWfCdihrNn62ENdnQvYZ1PLZFlvEyXEfh9A94?=
 =?us-ascii?Q?6RxGHXC8lIeo3Z5qBukZE9BeRbYOSphBkDRTf/kqP0hcLgsWOwdcnJAhuGB6?=
 =?us-ascii?Q?HlrW263YxRgwdVGvFvSYVJxM/Ajc9wSqwxempMh4CdmjVMpxuPNqNTDmGjj0?=
 =?us-ascii?Q?H8sA0Ly8UNwYKUkKqco9XUIxA6fPv3rMu93gkXYlmWgb4Xs7urPy+OWfemFi?=
 =?us-ascii?Q?afsR9v34A+fNDwmGeMxrmSYrfhSx4fxmWx33DiTF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZH/plmZyT4iWv8TfqU5UXQ2qaGe89iqfcj+TJ/K08A18s1HBVZG+bh3LmonoL/z98Vsi3Loc4aU20KrmfTapxNug44SuSviqCgsJX+cT1G9JHUbxoN0Q0lLPxkaHKajVeZ05+WDy8KoX2V0rAgoBeR2IM5WcmLMtU79VOZFvfwWIjDSVqK+EUsyuUe0FUAOToYT71D5zApG9HWYrNMR+4vy4W1/j+5bVTVqrq70bnJJs9PFL/Puc7ys/kb2slQg7hWJ33pEoYgsBjXvth0QwmlC3ti4vj+lUwZZtG2nt2GTWAsL0yFfBOhtrp04SdslA2Kpm72CNzybRuSxqI3ZTabH5uZHxYgN6ggB2D7cIsOceg7GVlPE9o+f6vcpgZ3D1m0470jcX1Fdnurjmtzo1Jf+ITHB3UDNIZ0uWlu6Xz2HbIM4o7EkdtVoKPazkF35IE3hD/zLpvS4rFzeBhnq2CTZDZ9GRJ1ATHTkWEprfo8ngWuTLPqO49JPzIySWFju8hVujTtooxE1+PekSTlS9N3/qko0Hb1tBEE74mQuEPejV3IZtvKTYz8dFW7m8w4iEUkmIGlTaWGLotK1IYoJ2Gev1BQr+44WH7i7b4VA3HpDVy4bCYi6rI/vtqBcZ7baA
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 739f43c9-085c-4d53-091c-08ddf5b87933
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 07:04:41.3112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8jxn+Xsmv6toNhLURAAGmOPnjsO0Q9GY4I25Zdk1PPk37kO5DYyZntSxc0rhlxEv2JnNfMX0WDP2PXwI0anDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P192MB2171
X-MS-Exchange-CrossPremises-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 14
X-MS-Exchange-CrossPremises-Mapi-Admin-Submission:
X-MS-Exchange-CrossPremises-MessageSource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-OriginalClientIPAddress: 104.151.95.196
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-Antispam-ScanContext:
	DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-Processed-By-Journaling: Journal Agent
X-OrganizationHeadersPreserved: DU2P192MB2171.EURP192.PROD.OUTLOOK.COM
X-Authority-Analysis: v=2.4 cv=PaL/hjhd c=1 sm=1 tr=0 ts=68ca5d8a cx=c_pps
 a=hM8yxYzsqXlWHy+t09BC9Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=8gLI3H-aZtYA:10 a=N9GNhs4bAAAA:8
 a=-n57fyUix78Y44btv20A:9 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-GUID: MY1MqAflqSumc_gv1Rs2C5A8FccJsNe8
X-Proofpoint-ORIG-GUID: MY1MqAflqSumc_gv1Rs2C5A8FccJsNe8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDA2NyBTYWx0ZWRfX98FqP87SEJMV
 zGQ0U78ROsSJGkNTnkgknenbaz1L0zoRLYlSPoY+y6RirvzZwmrFLkICI78UeLvndlu/gX4mChL
 XUfLweBT0MDWV+02TuWv1R5M9SQf/Z6tjOV4tnniTBcwX6IsOVXzYTE5NP/oJCqilwHxgYGmfXC
 1pgjSS36x/AMc42VE1PDnUeH5OB555ZqbV7wkFjrqvYJ+vDU7ABc1LzM4EHcSMCRONxT2iKBknh
 2N1ZNEnauO+hmy66kQi8QwEG9K+x0oXAfpVI7sj2WJ0yUfQjFgPE5sjdvWnTNRPtb43yXjQOkwO
 OLLumguuhbIgYnDum0IQRxMaNFMcL7se8dc0uC3jZByW7zHDVL9qD3SYOw+lbE=

Due to internal endianness handling within the QMI subsystem, all QMI
requests and responses must now be provided in CPU byte order. Replace all
QMI-related data types with CPU-endian types and add the necessary
conversions to ensure correct interpretation across architectures.

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 24 ++++++++++++++++--------
 drivers/net/wireless/ath/ath12k/qmi.h | 16 ++++++++--------
 2 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 7c611a1fd6d0..36325e62aa24 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -3307,20 +3307,28 @@ static int ath12k_qmi_wlanfw_wlan_cfg_send(struct ath12k_base *ab)
 	/* This is number of CE configs */
 	req->tgt_cfg_len = ab->qmi.ce_cfg.tgt_ce_len;
 	for (pipe_num = 0; pipe_num < req->tgt_cfg_len ; pipe_num++) {
-		req->tgt_cfg[pipe_num].pipe_num = ce_cfg[pipe_num].pipenum;
-		req->tgt_cfg[pipe_num].pipe_dir = ce_cfg[pipe_num].pipedir;
-		req->tgt_cfg[pipe_num].nentries = ce_cfg[pipe_num].nentries;
-		req->tgt_cfg[pipe_num].nbytes_max = ce_cfg[pipe_num].nbytes_max;
-		req->tgt_cfg[pipe_num].flags = ce_cfg[pipe_num].flags;
+		req->tgt_cfg[pipe_num].pipe_num =
+			__le32_to_cpu(ce_cfg[pipe_num].pipenum);
+		req->tgt_cfg[pipe_num].pipe_dir =
+			__le32_to_cpu(ce_cfg[pipe_num].pipedir);
+		req->tgt_cfg[pipe_num].nentries =
+			__le32_to_cpu(ce_cfg[pipe_num].nentries);
+		req->tgt_cfg[pipe_num].nbytes_max =
+			__le32_to_cpu(ce_cfg[pipe_num].nbytes_max);
+		req->tgt_cfg[pipe_num].flags =
+			__le32_to_cpu(ce_cfg[pipe_num].flags);
 	}
 
 	req->svc_cfg_valid = 1;
 	/* This is number of Service/CE configs */
 	req->svc_cfg_len = ab->qmi.ce_cfg.svc_to_ce_map_len;
 	for (pipe_num = 0; pipe_num < req->svc_cfg_len; pipe_num++) {
-		req->svc_cfg[pipe_num].service_id = svc_cfg[pipe_num].service_id;
-		req->svc_cfg[pipe_num].pipe_dir = svc_cfg[pipe_num].pipedir;
-		req->svc_cfg[pipe_num].pipe_num = svc_cfg[pipe_num].pipenum;
+		req->svc_cfg[pipe_num].service_id =
+			__le32_to_cpu(svc_cfg[pipe_num].service_id);
+		req->svc_cfg[pipe_num].pipe_dir =
+			__le32_to_cpu(svc_cfg[pipe_num].pipedir);
+		req->svc_cfg[pipe_num].pipe_num =
+			__le32_to_cpu(svc_cfg[pipe_num].pipenum);
 	}
 
 	/* set shadow v3 configuration */
diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
index abdaade3b542..4767d9a2e309 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.h
+++ b/drivers/net/wireless/ath/ath12k/qmi.h
@@ -392,17 +392,17 @@ enum qmi_wlanfw_pipedir_enum_v01 {
 };
 
 struct qmi_wlanfw_ce_tgt_pipe_cfg_s_v01 {
-	__le32 pipe_num;
-	__le32 pipe_dir;
-	__le32 nentries;
-	__le32 nbytes_max;
-	__le32 flags;
+	u32 pipe_num;
+	u32 pipe_dir;
+	u32 nentries;
+	u32 nbytes_max;
+	u32 flags;
 };
 
 struct qmi_wlanfw_ce_svc_pipe_cfg_s_v01 {
-	__le32 service_id;
-	__le32 pipe_dir;
-	__le32 pipe_num;
+	u32 service_id;
+	u32 pipe_dir;
+	u32 pipe_num;
 };
 
 struct qmi_wlanfw_shadow_reg_cfg_s_v01 {
-- 
2.43.0


