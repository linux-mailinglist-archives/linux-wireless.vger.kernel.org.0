Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0D86D297D
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Mar 2023 22:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbjCaUbC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Mar 2023 16:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbjCaUao (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Mar 2023 16:30:44 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2094.outbound.protection.outlook.com [40.92.22.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAA724AC1
        for <linux-wireless@vger.kernel.org>; Fri, 31 Mar 2023 13:30:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=csMBbynBY3lx4m/Lzt3eEb7v/0nnr0S/Js9SPsA/7B0/3cmt0ULWEcAydGp0z14cfeL9ciMaqMVlXdKQctChyZat0eD3azC9v/Kv6uC8uIkelbPDdhnEmfuTafam95WDeA5drOVgsP/LmdcfVO2KsTmSfIe1iewz2lmKE0/BIFohWAxi9WY22HDdYlaPxmf21xE+7fO6YzU25SCqOTgXkVBuDE2Z9/GG1lNUZ6mk3nBu82htUSFgXUbEYgF8zXFYV3Y7LgJzjJqRnKbDg7zjhn1Vn4Z3oe8nZmW6YDZv3E3fEwrQiN6RymQN2vbA7D5/xS21gshmX/OpEk3cwK+DiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GmgbpVOYDIWq2k46S6464MM01ZMoSO9YhbHFQpP6eXc=;
 b=LPFqWl0se4WT8JTpuIq3ifIKGdP7Db/QKvmuEmuV2nzW4NZi3uJWLgx98n4crwYb8XGTlsoFIhNDkrcKFgUeccnbvCQlkkt1n0SZDRzxyxtrBRVW4vIWtEoxEhm8uLS2sUoTysHC0Bj1X7Bem288B9OX44xFSXp2+LEc8UtLuPzBa20WT7afGGA6N5+GCu4RkudCHa7kjbtt1Ic2ufKktghAnqtcT6M+bYowWC6DtI3zwvSW93zgy0aPXWzMQbJF7wMJKjOEmoLi1kDg40kXm3OuWwqNRbxiC9c5zfpGzcTi9QUBoZWqNZ3vDfE/fNK/Xm4t9/3Pe/YMamIH0qkgOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmgbpVOYDIWq2k46S6464MM01ZMoSO9YhbHFQpP6eXc=;
 b=kMT+cKdi0iIFxZmMn0pWv1UCl6YFZTA7a21zIOXDbI8632ncas7ESnXRwr+PBBQW2HurIMJqYXCzlYwjs3qLZjuEtqJu7F0+FE92+5e/xzGs4290t2IXjMnrc6kfUZxW9YqgIFnJQORuSqfhOkGGHA+t3Ftz67zkN+gc+mN63YVIbuGdF3aFBt7xCSII3h3wVCQ7VT10ga1NUKuLcE9KW4qU7JfE3Ffn8AZxlMbyKXWit7vBTzOzP0Qd/ZTucIhiHhj0XQTtxvch6GDtgRcfFVpMlL8A+D6JEEUaQEKe7JlCia3HVEylGvszWV+R6Md5bXTKZYszjmn76QxBBm8nRA==
Received: from SJ0PR22MB2495.namprd22.prod.outlook.com (2603:10b6:a03:328::13)
 by MN2PR22MB2032.namprd22.prod.outlook.com (2603:10b6:208:1f4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.24; Fri, 31 Mar
 2023 20:30:10 +0000
Received: from SJ0PR22MB2495.namprd22.prod.outlook.com
 ([fe80::f3de:f07b:7676:239]) by SJ0PR22MB2495.namprd22.prod.outlook.com
 ([fe80::f3de:f07b:7676:239%6]) with mapi id 15.20.6254.022; Fri, 31 Mar 2023
 20:30:10 +0000
From:   Eric Sellman <GAK_ACTION@live.com>
To:     "sforshee@kernel.org" <sforshee@kernel.org>
CC:     "wireless-regdb@lists.infradead.org" 
        <wireless-regdb@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: wireless-regdb: Update regulatory rules for USA on 5GHz
Thread-Topic: wireless-regdb: Update regulatory rules for USA on 5GHz
Thread-Index: AQHZZAuPePAwlEV2ckub9GOe0GY7Iw==
Date:   Fri, 31 Mar 2023 20:30:09 +0000
Message-ID: <SJ0PR22MB249552E61991E3B2FAC911978F8F9@SJ0PR22MB2495.namprd22.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-tmn:  [wnkg8H3Ovaz2NQ+bZb4CE9F0t5xitihgGLXs3drcjng=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR22MB2495:EE_|MN2PR22MB2032:EE_
x-ms-office365-filtering-correlation-id: 8857454b-c7a6-423f-c2aa-08db3226b91e
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TV3C0cWprTTm47bC3BOpYtnkuhIrgsPfU1Nfv9VPGoUSPoOsi9fPV4BpJB6sz7/VXMF7Oyh+KcH4mSmaFdcK10ALGSeo5Rjq1+eZ78jkZaH3NvTdIcHVWw7WiUYxU0tHD02OH1wC4Fib2hi9tUYrGoR/F8Pou4m8BsmlWGStCUpWPESb7RgIYn5O8t2N6o902WEfHnnaVF/DAv6HpSV+eyzZr+q6cl2Xq0+ObFNRaKhvZaMuUoUbl536aLjsHm4iEy0PZcCOE6MprVqpDcA7IqRBbXH+Ei5FE+X3qWz3c7o9uiNMGV3xbQX2xnHVd/CKrmsHPDZLk3KXn+rtIL2JnFsCuEeEFXMrZANjj7rx/0mAokndM9OUaJkF4v3ttgAsGerI5Am2uNxPqQR5wI73kQE8coRNSax72lj4E0Vxtk+xuQqGv5W0jufYHHMCp7pmqQ8RsvZk0Bssy9crN61++AK2uaQdfysjwlJfq2zQGLMXreKBid2VLcqwaxhhALix6hJqfTk2RcMdL5QOL0nLGXYzBylf0t3luzOCOiIZif0=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5bGqmSQ6oFhq43qAiwb/gO54pCex/fUn3YdRZlz/Wia9hANr+nh/kiXrxb?=
 =?iso-8859-1?Q?FVAJPBnZtwZ/O8i8KqL4tpkxGymJTg3u2KgBOBw4gH3mLc4DGCeRdpgRIU?=
 =?iso-8859-1?Q?A/teZqIni5XM+0uv7DDp3d5jkGTJIYPf2ET4R/vx8sFmT9uT4ZgbShLGqB?=
 =?iso-8859-1?Q?GvcViyPdaWSTbCLnzz1NH9S2QZ8eGtFcXOi3CBtSsFmtLz80p3vduuCxHd?=
 =?iso-8859-1?Q?Dvxhm5Z8vg5yCl1HpUY8F2dZbCuLDJ2dxCoeA/8/gs10m2iM+sVFwHQBMt?=
 =?iso-8859-1?Q?+GqrRrR7l0Ijeuvj/JWPlYP+J0VbAmR03j/ww7JgRUZkAB2fq+ere6bUe/?=
 =?iso-8859-1?Q?OqgISEd1D9J+00bDDi3t9iOhIwRCfX7dXBGYgV6Rzu2nWJ4AQ8ibaPSjgY?=
 =?iso-8859-1?Q?Wd0TSIIGwZkPny2LMmpzFWliEAOA1b1Tvm6TmC8QN/lKXNy6sRC2k6Ytoi?=
 =?iso-8859-1?Q?QTD/KOVn5vZxE5ywzDT5Yfq9D+YPObjOxzFPDUj5VkzVdqZl/tbLeZdFXY?=
 =?iso-8859-1?Q?eQExA0Lr/n9l9N0fWzUq/4ovG22j9uyqfck1MMSOeyrOL0ZqPKoZuCJBL+?=
 =?iso-8859-1?Q?jtuWKHRIDJy5VdokyIK7YcJ1rdX70JoQR9txEeiFaS2Nme8hwaXC+0RXRI?=
 =?iso-8859-1?Q?1aTGz2o+VrP+AeofvQSIXluRagd1VVcWzgx44OmS/hx9zaji/Ruw8WNM6e?=
 =?iso-8859-1?Q?mytSNSWWtlS1SKQjrjRvV9qgbzLcic6pC4VSBF5phQEbe/8JJudPoHRCx7?=
 =?iso-8859-1?Q?2/JepJKPcI+UW9w2y7+oOQ4v7ULY9yU8CXGZz4MhB0WGfuEwfEnK0oimNR?=
 =?iso-8859-1?Q?kckqB4p/3rlNIoUf5jeROQ42MYps+1rSYML/FMnUU1jzD65LUcbPgGBvjH?=
 =?iso-8859-1?Q?5g3CkoD2VUxCSz9Ph2OfDPqBJJWm7glAEyxblMhP7ttkExkj1BUpI8V0jU?=
 =?iso-8859-1?Q?iUZy8sBO/koM0xPD3V6/pgWZncETF/lYrw/eid3RhJ8bb7dxUEuDI+L9dm?=
 =?iso-8859-1?Q?JNiSykPs+l5Pxb1vvJywkzNMstUyX8nZzK4gmrRHTeGW/7iTJxyvyc8AYZ?=
 =?iso-8859-1?Q?HRqzwVLgbDDukjsp7gzK+NskBrnDMkpw+cCum/KdBKdfxawB+bTJG3Y0MJ?=
 =?iso-8859-1?Q?MrFsbwJP/9p/nMVlfUNjld+vRv+R97Xe3mL5akIDk55WqaKvdrzar4ztJG?=
 =?iso-8859-1?Q?LJfev4c6fK8wntxAhZc7rR/VJej9o5FJTI7teZlsw72FIOdQBum1dqmFON?=
 =?iso-8859-1?Q?YbhrpASGC/Krw2oKVUmg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-c3c87.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR22MB2495.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8857454b-c7a6-423f-c2aa-08db3226b91e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2023 20:30:09.8992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR22MB2032
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

First, I would like to state that I live in the USA And that this is my fir=
st time submitting a correction to the wireless-regdb.=0A=
=0A=
According to this list here >>=A0https://git.kernel.org/pub/scm/linux/kerne=
l/git/sforshee/wireless-regdb.git/tree/db.txt#n1727=0A=
=0A=
I only see VHT160 allowed to be utilized for 5500mhz to 5640mhz but there i=
s no mention of VH160 being allowed for use with 5180 to 5320mhz.=0A=
=0A=
And according to this presentation here > https://transition.fcc.gov/oet/ea=
/presentations/files/may17/31-Part-15-Panel-UNII-UpdatesDT.pdf=0A=
=0A=
And this paragraph from this FCC document here > https://www.federalregiste=
r.gov/d/2014-09279/p-65=0A=
=0A=
"Band Straddling" is allowed with U-NII-1 and U-NII-2A. 5150mhz to 5330mhz=
=0A=
=0A=
Therefore, I would like you to add to the db that 5180 to 5320 can be used =
with vht160.=
