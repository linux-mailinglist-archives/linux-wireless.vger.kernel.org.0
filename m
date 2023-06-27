Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A1F73F48A
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jun 2023 08:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjF0Gb2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Jun 2023 02:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjF0Gb0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Jun 2023 02:31:26 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2065.outbound.protection.outlook.com [40.92.98.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A8BF4
        for <linux-wireless@vger.kernel.org>; Mon, 26 Jun 2023 23:31:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfK911cLAhZzAo9+QR5//RZVC88NNInMCjXx4800gwuz7WiJ/wjtvih75ursBk36WIkjqQHl0lCH4AIYDpfR78Sqsyj5++nBFwvYG1NsZ3/81Pa7dNgJs1DVGNNEKYi4oTzT/dIfQA3AhHEgIIeM8bTFBicp+OTfMx8bpNtx/Nf8tlBm1VBDm3y6nDOYjKVCMk+dwNMaHC/1aI+bFK72WfZbeVYNuA1b0eaa0yOjpa6/WSmD+Exf25g+QM/pFRynsj6B0Vm2XisflnfQzOQ688q+1D2bzEzT8DosbZNb5QImBCang8JrK4aa+UZw3cRSIMPFm4ochJN6NImXKqbCyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjU/IRtFudFA+DVbztt2IbB1dmb775PsPxnxuz1VeCM=;
 b=OHWnbh5EcFcbmHBzV4J/90iDbMnsrNfaZvEqftoLS7L+9UgqGyYPfWPpcFzc6BycOjzhK2FF9aPkiOEBprIvWQHhAxv2/ysd9MifZjLUvBjWSggUYpmx6zOGZQMQXNk9hj4eR1GUEkadayt1pdiKHfQiPNgYXjw092mDWaogCNvRVNIsl733l2IVVgBCQJEF9wkL9tDoFw5+l3YfwJhR49Nl20nzxmIFkGhw/gv1pbVOTaRdtO6M/XdoUzhSli8jRJw+QP80DnyyEAtedD7PrZFLfExyv8oQYC9YphAY3ry1xnD51TyHuUkYRuV/0N8HD0FXA8iKGfwUMc95Sl7kJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjU/IRtFudFA+DVbztt2IbB1dmb775PsPxnxuz1VeCM=;
 b=LJx14SNr001yrhgJQqIvOZZE7K/kh8FZnnrSlhu9rXvjOvTAjguxTt4ytH3Z1ZOYCXvUtlkFl6nQ2kLUz5/hroKXenCcWlmqzP9uOK8OhR9pw+D7h/fCuHLCLOouez4udzO6GPXp8srlTTQX1vclfBsXasDjReZBrS0CK5/13ikeAWVmsfRBARveWASsNZ2UiLJqWnUbARQmJwAjcawfYACyE75KOGiGnD/vGKWkfAWwVfInsl4uAMfBPwqeRXO96TGeTzH66nKvWcCBT4lKwEQ0xlHxZZ/ovSKfFsNtYSlAU514pRN5Oz5Zy9buTBlKLnFmNOZOGaa9k7t0zDeDIg==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TYCP286MB1683.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:185::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 06:31:22 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ca7e:d73d:ba3f:64a6]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ca7e:d73d:ba3f:64a6%5]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 06:31:22 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     lorenzo@kernel.org
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        nbd@nbd.name
Subject: Re: [PATCH wireless-next] wifi: mt76: mt76x02: remove WEP support
Date:   Tue, 27 Jun 2023 14:31:11 +0800
Message-ID: <TYAP286MB0315F8381D7746A98C01435FBC27A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <d560f1a16c9024b6e4029bd0baf53384f4552f5a.1683020788.git.lorenzo@kernel.org>
References: <d560f1a16c9024b6e4029bd0baf53384f4552f5a.1683020788.git.lorenzo@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [Gc43TYyHj9h9yGETB1ythvUaRlPXP+/b]
X-ClientProxiedBy: TYCP286CA0259.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::7) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20230627063111.349-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TYCP286MB1683:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ed401c6-9ade-4cdb-a3b4-08db76d81fcc
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 91ZPBPcXDAmeuAiJg2Gbx3ZGDqoaAQA2ChqwphV8otihec5jUpZp/kniC3ThD8Bt+tZ09+g6+KvpalPqsC8J5QxJl7nlRZvVt2etatxk2PHTgn4NziujnDRPh8VfJfT5jTQGE8oXGDy/GGiqfMRGNGt15vynai5UG6P7EB/mET4HBTVJL6CjEK/vg3Ws8OVE9IsQi3ClcQIpyElU5PUo6mJTqJDnGsc3hE3SJhNTX9DscQTbhQTRwqpM4WcpdcEyXROP+fipLs21a5tKkrNTci/BNTyIFpy0GsQfFCe3wnyyrp5xblkc9/unM1fXpVt2YGqpw11NiJ69zs0hpjzZeqcPzWbUbK6vNHoeXQ7FTewq8jBIJhLuEyzBtmgOZ4Rz+fK2aLq/F1pCVn+OiIbLy37CSEne8ocn6/tq1ag7cL8MKOurQg0UpUA50ri12LAAxzvrK9ZWjPtBq9rzOzqcspostyhxWmj5YT7SlB6+wjhtIM/qBNDjEFth1IVAo+y2cL8wnKql80M9LxCvae8ZZmkS8FsOnu20lld9i0duYbmvXAHYI2sSN76/ziFu6shN
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?czZ1iXTQeZBnx8sY/9SR4NacjBviU/isOWdTLZZ111w6/THxK0s+jsnGuM3D?=
 =?us-ascii?Q?5tuMMF4WiwAiu7JC3GvasX9SA9XNs9C+Caq9RhvAt2OvihGK4OwNwR3rCX0T?=
 =?us-ascii?Q?dkOHHg8qAT9EaiUO/mEv8hx2DUTZiq5HOCFZJSF55IFcuVljJEkGQtleTcQ2?=
 =?us-ascii?Q?pWRF+JT3jdpaFOZ14cxkbvr69+YeRf2PUumrB194dRuMwF2/df/0zjWsOM/4?=
 =?us-ascii?Q?9NbLvtuXe+08EC2CbyZx8pC0pXZN/r6AUkOU4axAu83PVvfYhjv4GxXeEDBx?=
 =?us-ascii?Q?AEJ9EKbGZX9rlNvlJ14GixJXI2A4pmId3NVztCRMZ7ChwX+XwmBM0eHWtXO7?=
 =?us-ascii?Q?OWdXueJ1CYeqlDlPHsuqP7+/mpa9Li+p7H2fyqJvJPl7rUeln4GHZJX45EGw?=
 =?us-ascii?Q?hpnjDtaQBZmL9sTw1GF+5vVlgwPmkvx3PPXUwDPZ9ANdhJSnYvWvXpS0CSde?=
 =?us-ascii?Q?T9mFvYozau8zxDZgAac6ziRX3AEZlxQro0G3cRrn6hRZu7taulNB/8FK+NBj?=
 =?us-ascii?Q?vt29Ay/Qv+VsFXE/o5KzvoPJvYYqPTZZXP98waTQ1udcCYgyaLbva5GxivT9?=
 =?us-ascii?Q?Db0rpQOgAkTvDsxC+cLU7B0KaeVfA98Y/jLMzfBNpC1JXTjvAML3bOj/HgbX?=
 =?us-ascii?Q?IlwO17Vtf/EkWvicAGGk2iEIEja3vx7cWAF1aotMpFcaOqa9dbfZ6TaZsqbx?=
 =?us-ascii?Q?tFUvRX+9n/qDdChdBXMA5OdyL9AEOa/yHBHf1biPHzyeIJgJz/oMuzY7fPH4?=
 =?us-ascii?Q?rmFAwa2R8dNBGxPha64Y+4D8ESfmmBlVqIDPgqlG/JupW0lf+X65mW4WzJqB?=
 =?us-ascii?Q?OTwpBIkKmsqcgzxpV/WWUfZQg4xBUmLcqKH6NoXuFL6slBDDVmj4J6AnuLef?=
 =?us-ascii?Q?zU9+E+SCVzF71R9IVnqeEjc68z3IcnpkopgkPFoueqYUcW6Qo1j1sPOm0PoE?=
 =?us-ascii?Q?EbPL11P7GuzFRO+iQi2KTjtfGQCDHOpWkBbRN4AEaVQes9fvSQCSERpzdags?=
 =?us-ascii?Q?cPN9j2EKBZubKxOnMtGRnYIIrOKRpT/B3eXxfSUPkQ6D+euQuLngkFu9zP2i?=
 =?us-ascii?Q?XZN3eTLP2JwCiajgkW3vGjM7R8J4Zof2tDSOJgA80ttF2UPOdXuwAJkMe49R?=
 =?us-ascii?Q?tpGJ9H5T+wYklqgI3EsSqrZ+YDfsvnwqafocvP5Hz+Bq31WhabG5L40LF0TB?=
 =?us-ascii?Q?oo06JF10b4A52jRyB4I1gysNhkwJGtsNgPHiTGn4mk2xid1yJfNAvslczD8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed401c6-9ade-4cdb-a3b4-08db76d81fcc
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 06:31:22.8912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1683
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:
>@@ -471,16 +468,6 @@ int mt76x02_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
> 	}
> 	mt76_wcid_key_setup(&dev->mt76, wcid, key);
> 
>-	if (!msta) {
>-		if (key || wcid->hw_key_idx == idx) {
>-			ret = mt76x02_mac_wcid_set_key(dev, wcid->idx, key);
>-			if (ret)
>-				return ret;
>-		}
>-
>-		return mt76x02_mac_shared_key_setup(dev, mvif->idx, idx, key);
>-	}
>-
> 	return mt76x02_mac_wcid_set_key(dev, msta->wcid.idx, key);
> }
> EXPORT_SYMBOL_GPL(mt76x02_set_key);

`msta` may be a null pointer. This patch may cause data to be written to a
null pointer in `return mt76x02_mac_wcid_set_key(dev, msta->wcid.idx, key);`.
