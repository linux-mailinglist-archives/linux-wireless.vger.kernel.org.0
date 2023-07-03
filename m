Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6364745CF9
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jul 2023 15:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjGCNR5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Jul 2023 09:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjGCNR4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Jul 2023 09:17:56 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F42E3
        for <linux-wireless@vger.kernel.org>; Mon,  3 Jul 2023 06:17:53 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230703131751epoutp012acf4855bf93c4c97214329895945426~uXgGTcg_m2487224872epoutp01U
        for <linux-wireless@vger.kernel.org>; Mon,  3 Jul 2023 13:17:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230703131751epoutp012acf4855bf93c4c97214329895945426~uXgGTcg_m2487224872epoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1688390271;
        bh=+noCVj8IZxKilu+ApMJfqRhNqqMewKdzTmQQ3GKkJ/E=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=FGPBNu0r33BahYyOSMJdsstOYVor+CqIkHOpeoofv/xWKHBKYequOz8lmz45fSH91
         Hn96AoCn2KGwmsvdRAvXVgTEH91i4NeILkg6fA6jQG+WCxzl+KhDRJHobMfs/kSQ9Z
         OgKB9r3eJpYqVMKOCLz6jwJfAQP+UBBCqFT/Cl/o=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230703131750epcas5p1034cc47c94a7567b9cc107b5fa9cd343~uXgGDfInM2113621136epcas5p1r;
        Mon,  3 Jul 2023 13:17:50 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Qvmgd53n4z4x9Pp; Mon,  3 Jul
        2023 13:17:49 +0000 (GMT)
X-AuditID: b6c32a49-67ffa7000000d8e2-ba-64a2ca7deb75
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        14.CC.55522.D7AC2A46; Mon,  3 Jul 2023 22:17:49 +0900 (KST)
Mime-Version: 1.0
Subject: External Auth FILS Authentication
Reply-To: k.velayutham@samsung.com
Sender: Kavitha Velayutham <k.velayutham@samsung.com>
From:   Kavitha Velayutham <k.velayutham@samsung.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC:     Pragya Gupta <pragya.gupta@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230628045628epcms5p5b1820343f828e3229035d6313fe735ce@epcms5p5>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230703082654epcms5p42bf0d3816b990c13a4f1d7272c4c8e7b@epcms5p4>
Date:   Mon, 03 Jul 2023 13:56:54 +0530
X-CMS-MailID: 20230703082654epcms5p42bf0d3816b990c13a4f1d7272c4c8e7b
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFKsWRmVeSWpSXmKPExsWy7bCmpm7tqUUpBpOOK1h83PCJxeLNijvs
        Fi/3Fzswe/RtWcXo0d+7jcXj8ya5AOaobJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11D
        SwtzJYW8xNxUWyUXnwBdt8wcoD1KCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAKT
        Ar3ixNzi0rx0vbzUEitDAwMjU6DChOyMDcs7mAqu7GKs2PV7J3sD4/OtjF2MnBwSAiYSi5r+
        sXQxcnEICexmlFjz4C5TFyMHB6+AoMTfHcIgNcICWhLb3h9hB7GFBJQkJqz7wQQRN5Xo2LaP
        DcRmEzCWuH+lhxFkjohAA6NE9+mDzCAJZgFtid4zv9kglvFKzGh/ygJhS0tsXw5xBKeAn8TM
        CxuZIOKiEjdXv2WHsd8fmw91qIhE672zzBC2oMSDn7uh4lISfX9OQM3Plmh48RvsfgmBEomr
        l60hTHOJP9t0Ib7ylWhZB/YVi4CqRPeEmawQjS4S615NZYM5eNnC18wg5cwCmhLrd+lDlMhK
        TD21jgmihE+i9/cTJpifdsyDsdUkTnSsgvpPRmJxA8yvHhKtS5czQwJwB5NE/z+pCYwKsxDB
        PAvJ4lkIixcwMq9ilEwtKM5NTy02LTDMSy2HR29yfu4mRnCi0/LcwXj3wQe9Q4xMHIyHGCU4
        mJVEeJsfzk8R4k1JrKxKLcqPLyrNSS0+xGgK9PVEZinR5Hxgqs0riTc0sTQwMTMzM7E0NjNU
        Eud93To3RUggPbEkNTs1tSC1CKaPiYNTqoHJP8h6SeRxo/TiZPal56qdGI+9yJijM9l7QslU
        9prWY1/iNjD+K7VawqZo/LSsKzY9/ayr/5xF4ZWGASGfFvYE/t3+6RCb96YzB/keO1TdLm/Q
        rWO1/J5d/ll04427AsJxpyU3SLb5zc+7+8r7Zv+Bjx9fPNsa5lc3e5ak2/EtRoZnazOvRbj/
        +OS/de6dXJ9wrwecjdsjGv4E9UYwfGEVi26u2FvtumPGMt9tB9tCMvcG7ui68Yjd9u40nUzO
        w2mad7/fzN/rbFFu23p6ZwrbF/89Ky9tmODhU1atax2k4Bz9a+7O8r0MM71E7tXYy6/d+8t7
        UdOxnklbT0zLaYk4nvHcgfXcRu6GJytVeM8osRRnJBpqMRcVJwIAoaOVWP0DAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230622102548epcas5p3e347215405116f1b64befe72ec99d567
References: <20230628045628epcms5p5b1820343f828e3229035d6313fe735ce@epcms5p5>
        <20230622103041epcms5p873a0f3404f38216c9802f6b299787d9d@epcms5p8>
        <202306221827.35MIRU0c2989147@administrator-PowerEdge-R740xd.sa.corp.samsungelectronics.net>
        <CGME20230622102548epcas5p3e347215405116f1b64befe72ec99d567@epcms5p4>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Author: Kavitha Velayutham <k.velayutham=40samsung.com>
Date:=C2=A0=20=20Thu=20Jun=2022=2023:48:11=202023=20+0530=0D=0A=C2=A0=0D=0A=
=C2=A0=20=C2=A0=20=5BPatch=201/1=5D=20changes=20for=20FILS=20Authentication=
=20for=20External=20Auth=0D=0A=C2=A0=20=C2=A0=20=0D=0A=C2=A0=20=C2=A0=20For=
=20Auth=20to=20be=20handled=20by=20supplicant=20when=20sme=20is=20in=20lowe=
r=20layers=20for=20FILS=20Authentication=20and=0D=0A=C2=A0=20=C2=A0=20to=20=
send=20Assoc=20params=20to=20the=C2=A0=20Lower=20layers.=0D=0A=C2=A0=20=C2=
=A0=20=0D=0A=C2=A0=20=C2=A0=20Signed-off-by:=20Kavitha=20Velayutham=20<k.ve=
layutham=40samsung.com>=0D=0A=C2=A0=0D=0Adiff=20--git=20a/include/net/cfg80=
211.h=20b/include/net/cfg80211.h=0D=0Aold=20mode=20100644=0D=0Anew=20mode=
=20100755=0D=0Aindex=209e04f69712b1..ac61d326f0f3=0D=0A---=20a/include/net/=
cfg80211.h=0D=0A+++=20b/include/net/cfg80211.h=0D=0A=40=40=20-3467,6=20+346=
7,16=20=40=40=20struct=20cfg80211_update_ft_ies_params=20=7B=0D=0A=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0size_t=20ie_len;=0D=0A=20=7D;=0D=0A=20=0D=
=0A+=23ifdef=20CONFIG_SCSC_WLAN_OCE=0D=0A+struct=20cfg80211_external_fils_a=
ssoc_params=20=7B=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0const=20u8=20*f=
ils_kek;=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0size_t=20fils_kek_len;=
=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0const=20u8=20*ie;=0D=0A+=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0size_t=20ie_len;=0D=0A+=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0const=20u8=20*fils_nonces;=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0size_t=20fils_nonces_len;=0D=0A+=7D;=0D=0A+=23endif=0D=0A=20/**=0D=
=0A=C2=A0=20*=20struct=20cfg80211_mgmt_tx_params=20-=20mgmt=20tx=20paramete=
rs=0D=0A=C2=A0=20*=0D=0A=40=40=20-4626,6=20+4636,10=20=40=40=20struct=20cfg=
80211_ops=20=7B=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0struct=20net_device=20*dev);=0D=0A=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0int=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0(*update_ft_=
ies)(struct=20wiphy=20*wiphy,=20struct=20net_device=20*dev,=0D=0A=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20struct=
=20cfg80211_update_ft_ies_params=20*ftie);=0D=0A+=23ifdef=20CONFIG_SCSC_WLA=
N_OCE=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0int=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0(*set_fils_assoc_params)(struct=20wiphy=20*wiphy,=20struct=20ne=
t_device=20*dev,=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20struct=20cfg80211_=
external_fils_assoc_params=20*ftie);=0D=0A+=23endif=0D=0A=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0int=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0(*crit_proto=
_start)(struct=20wiphy=20*wiphy,=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=20struct=20wireless_=
dev=20*wdev,=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=20enum=20nl80211_crit_proto_id=20protocol=
,=0D=0Adiff=20--git=20a/include/uapi/linux/nl80211.h=20b/include/uapi/linux=
/nl80211.h=0D=0Aold=20mode=20100644=0D=0Anew=20mode=20100755=0D=0Aindex=20c=
59fec406da5..6ef927c966d3=0D=0A---=20a/include/uapi/linux/nl80211.h=0D=0A++=
+=20b/include/uapi/linux/nl80211.h=0D=0A=40=40=20-1562,6=20+1562,10=20=40=
=40=20enum=20nl80211_commands=20=7B=0D=0A=20=0D=0A=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0NL80211_CMD_SET_HW_TIMESTAMP,=0D=0A=20=0D=0A+=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0NL80211_CMD_SET_SAR_SPECS,=0D=0A+=0D=0A+=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0NL80211_CMD_FILS_ASSOC_REQ_INFO,=0D=0A+=0D=0A=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0/*=20add=20new=20commands=20above=20=
here=20*/=0D=0A=20=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0/*=20used=
=20to=20define=20NL80211_CMD_MAX=20below=20*/=0D=0A=40=40=20-1581,6=20+1585=
,7=20=40=40=20enum=20nl80211_commands=20=7B=0D=0A=20=23define=20NL80211_CMD=
_DEAUTHENTICATE=20NL80211_CMD_DEAUTHENTICATE=0D=0A=20=23define=20NL80211_CM=
D_DISASSOCIATE=20NL80211_CMD_DISASSOCIATE=0D=0A=20=23define=20NL80211_CMD_R=
EG_BEACON_HINT=20NL80211_CMD_REG_BEACON_HINT=0D=0A+=23define=20NL80211_CMD_=
FILS_ASSOC_REQ_INFO=20NL80211_CMD_FILS_ASSOC_REQ_INFO=0D=0A=20=0D=0A=20=23d=
efine=20NL80211_ATTR_FEATURE_FLAGS=20NL80211_ATTR_FEATURE_FLAGS=0D=0A=20=0D=
=0A=40=40=20-3302,6=20+3307,14=20=40=40=20enum=20nl80211_attrs=20=7B=0D=0A=
=20=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0NL80211_ATTR_DISABLE_HE,=
=0D=0A=20=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0NL80211_ATTR_FILS_ASSOC=
_IE,=0D=0A+=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0NL80211_ATTR_RECONNEC=
T_REQUESTED,=0D=0A+=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0NL80211_ATTR_=
SAR_SPEC,=0D=0A+=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0NL80211_ATTR_DIS=
ABLE_HE,=0D=0A+=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0NL80211_ATTR=
_OBSS_COLOR_BITMAP,=0D=0A=20=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0NL80211_ATTR_COLOR_CHANGE_COUNT,=0D=0A=40=40=20-6443,7=20+6456,7=20=40=
=40=20enum=20nl80211_ext_feature_index=20=7B=0D=0A=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0NL80211_EXT_FEATURE_PUNCT,=0D=0A=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0NL80211_EXT_FEATURE_SECURE_NAN,=0D=0A=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0NL80211_EXT_FEATURE_AUTH_AND_DEAUTH_RANDOM_TA,=0D=
=0A-=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0NL80211_EXT_FEATURE_EXTERNAL=
_AUTH_FILS,=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0/*=20add=20new=
=20features=20before=20the=20definition=20below=20*/=0D=0A=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0NUM_NL80211_EXT_FEATURES,=0D=0A=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0MAX_NL80211_EXT_FEATURES=20=3D=20NUM_NL80211_EXT=
_FEATURES=20-=201=0D=0Adiff=20--git=20a/net/wireless/Kconfig=20b/net/wirele=
ss/Kconfig=0D=0Aindex=20f620acd2a0f5..cac4586e21e1=20100644=0D=0A---=20a/ne=
t/wireless/Kconfig=0D=0A+++=20b/net/wireless/Kconfig=0D=0A=40=40=20-67,6=20=
+67,11=20=40=40=20config=20CFG80211_DEVELOPER_WARNINGS=0D=0A=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=C2=A0=20Say=20Y=20only=20if=20you=20are=20devel=
oping=20cfg80211=20or=20a=20driver=20based=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=C2=A0=20on=20it=20(or=20mac80211).=0D=0A=20=0D=0A+config=20=
SCSC_WLAN_OCE=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0bool=20=22OCE=20Aut=
h=20Support=20with=20External=20Auth=22=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0default=20y=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0help=0D=0A+=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=C2=A0=20This=20option=20enables=20exte=
rnal=20Auth=20Support=20for=20FILS=20Authentication=0D=0A=20=0D=0A=20config=
=20CFG80211_CERTIFICATION_ONUS=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0bool=20=22cfg80211=20certification=20onus=22=0D=0Adiff=20--git=20a/net/w=
ireless/nl80211.c=20b/net/wireless/nl80211.c=0D=0Aold=20mode=20100644=0D=0A=
new=20mode=20100755=0D=0Aindex=20d95f8053020d..b78236883b84=0D=0A---=20a/ne=
t/wireless/nl80211.c=0D=0A+++=20b/net/wireless/nl80211.c=0D=0A=40=40=20-559=
,6=20+559,11=20=40=40=20static=20const=20struct=20nla_policy=20nl80211_poli=
cy=5BNUM_NL80211_ATTR=5D=20=3D=20=7B=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=5BNL80211_ATTR_IE=5D=20=3D=20NLA_POLICY_VALIDATE_FN(NLA_BINARY,=
=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=C2=A0=20=20validate_ie_attr,=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=C2=A0=20=20IEEE80211_MAX_DATA_LEN),=0D=
=0A+=23ifdef=20CONFIG_SCSC_WLAN_OCE=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=5BNL80211_ATTR_FILS_ASSOC_IE=5D=20=3D=20NLA_POLICY_VALIDATE_FN(NLA_BINA=
RY,=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20validate_=
ie_attr,=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20IEEE80=
211_MAX_DATA_LEN),=0D=0A+=23endif=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=5BNL80211_ATTR_SCAN_FREQUENCIES=5D=20=3D=20=7B=20.type=20=3D=20NLA_N=
ESTED=20=7D,=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=5BNL80211_ATTR=
_SCAN_SSIDS=5D=20=3D=20=7B=20.type=20=3D=20NLA_NESTED=20=7D,=0D=0A=20=0D=0A=
=40=40=20-5844,10=20+5849,11=20=40=40=20static=20bool=20nl80211_valid_auth_=
type(struct=20cfg80211_registered_device=20*rdev,=0D=0A=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(auth_type=
=20=3D=3D=20NL80211_AUTHTYPE_FILS_SK_PFS=20=7C=7C=0D=0A=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=
=20auth_type=20=3D=3D=20NL80211_AUTHTYPE_FILS_PK)=0D=0A=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0return=20false;=0D=0A-=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(=21wiphy_ext_feature_isset(=
=0D=0A-=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=20&rdev->wiphy,=
=0D=0A-=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=20NL80211_EXT_FEA=
TURE_FILS_SK_OFFLOAD)=20&&=0D=0A-=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=20auth_type=20=3D=3D=20NL8021=
1_AUTHTYPE_FILS_SK)=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0if=20(=21(wiphy_ext_feature_isset(&rdev->wiphy,=20N=
L80211_EXT_FEATURE_FILS_SK_OFFLOAD)=0D=0A+=23ifdef=20CONFIG_SCSC_WLAN_OCE=
=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=C2=A0=20=C2=A0=20=7C=7C=20wiphy_ext_feature_isset(&rdev->wiphy,=20NL=
80211_EXT_FEATURE_EXTERNAL_AUTH_FILS)=0D=0A+=23endif=0D=0A+=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=20=
)=20&&=20auth_type=20=3D=3D=20NL80211_AUTHTYPE_FILS_SK)=0D=0A=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0return=20false;=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0return=20true;=0D=0A=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0case=20NL80211_CMD_START_AP:=0D=0A=
=40=40=20-11929,9=20+11935,11=20=40=40=20static=20int=20nl80211_connect(str=
uct=20sk_buff=20*skb,=20struct=20genl_info=20*info)=0D=0A=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7D=0D=0A=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7D=0D=0A=20=0D=0A-=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0if=20(wiphy_ext_feature_isset(&rdev->wiphy,=0D=0A-=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=C2=A0=20=C2=
=A0=20NL80211_EXT_FEATURE_FILS_SK_OFFLOAD)=20&&=0D=0A-=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=C2=A0=20=C2=A0=20info->attrs=5BNL80211_ATTR_FILS_ERP_USERNA=
ME=5D=20&&=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20((wiphy_ext_featu=
re_isset(&rdev->wiphy,=20NL80211_EXT_FEATURE_FILS_SK_OFFLOAD)=0D=0A+=23ifde=
f=20CONFIG_SCSC_WLAN_OCE=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=C2=A0=
=20=C2=A0=20=7C=7C=20wiphy_ext_feature_isset(&rdev->wiphy,=20NL80211_EXT_FE=
ATURE_EXTERNAL_AUTH_FILS)=0D=0A+=23endif=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=C2=A0=20=C2=A0=20)=20&&=20info->attrs=5BNL80211_ATTR_FILS_ERP_USE=
RNAME=5D=20&&=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=C2=A0=20=C2=
=A0=20info->attrs=5BNL80211_ATTR_FILS_ERP_REALM=5D=20&&=0D=0A=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=20info->attrs=5BNL80211_ATTR_=
FILS_ERP_NEXT_SEQ_NUM=5D=20&&=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=C2=A0=20=C2=A0=20info->attrs=5BNL80211_ATTR_FILS_ERP_RRK=5D)=20=7B=0D=
=0A=40=40=20-12013,8=20+12021,8=20=40=40=20static=20int=20nl80211_update_co=
nnect_params(struct=20sk_buff=20*skb,=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0changed=20=7C=3D=20UPDATE_A=
SSOC_IES;=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7D=0D=0A=20=0D=0A=
-=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0fils_sk_offload=20=3D=20wiphy_ext_feat=
ure_isset(&rdev->wiphy,=0D=0A-=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=C2=A0=20NL80211_EXT_FEATURE_FILS_SK_OFFLOAD);=0D=0A+=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0fils_sk_offload=20=3D=20wiphy_ext_featu=
re_isset(&rdev->wiphy,=20NL80211_EXT_FEATURE_FILS_SK_OFFLOAD)=20=7C=7C=0D=
=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=C2=A0=20wiphy_ext_feature_isset(&rd=
ev->wiphy,=20NL80211_EXT_FEATURE_EXTERNAL_AUTH_FILS);=0D=0A=20=0D=0A=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0/*=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20*=20when=20driver=20supports=20fils-sk=20offload=20all=20att=
ributes=20must=20be=0D=0A=40=40=20-14789,6=20+14797,33=20=40=40=20static=20=
int=20nl80211_update_ft_ies(struct=20sk_buff=20*skb,=20struct=20genl_info=
=20*info)=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0return=20rdev_upda=
te_ft_ies(rdev,=20dev,=20&ft_params);=0D=0A=20=7D=0D=0A=20=0D=0A+=23ifdef=
=20CONFIG_SCSC_WLAN_OCE=0D=0A+static=20int=20nl80211_fils_assoc_req_ies(str=
uct=20sk_buff=20*skb,=20struct=20genl_info=20*info)=0D=0A+=7B=0D=0A+=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0struct=20cfg80211_registered_device=20*rdev=
=20=3D=20info->user_ptr=5B0=5D;=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0s=
truct=20cfg80211_external_fils_assoc_params=20fils_params;=0D=0A+=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0struct=20net_device=20*dev=20=3D=20info->user_pt=
r=5B1=5D;=0D=0A+=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(=21rdev->o=
ps->set_fils_assoc_params)=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0return=20-EOPNOTSUPP;=0D=0A+=0D=0A+=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0if=20(=21info->attrs=5BNL80211_ATTR_FILS_KEK=5D=
=20=7C=7C=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=20=21in=
fo->attrs=5BNL80211_ATTR_FILS_ASSOC_IE=5D=20=7C=7C=0D=0A+=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=20=21info->attrs=5BNL80211_ATTR_FILS_NONC=
ES=5D)=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0return=20-EINVAL;=0D=0A+=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0memset(&fils_params,=200,=20sizeof(fils_params));=0D=0A+=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0fils_params.fils_kek=20=3D=20nla_data(info->attrs=
=5BNL80211_ATTR_FILS_KEK=5D);=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0fil=
s_params.fils_kek_len=20=3D=20nla_len(info->attrs=5BNL80211_ATTR_FILS_KEK=
=5D);=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0fils_params.ie=20=3D=20nla_=
data(info->attrs=5BNL80211_ATTR_FILS_ASSOC_IE=5D);=0D=0A+=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0fils_params.ie_len=20=3D=20nla_len(info->attrs=5BNL80211_=
ATTR_FILS_ASSOC_IE=5D);=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0fils_para=
ms.fils_nonces=20=3D=20nla_data(info->attrs=5BNL80211_ATTR_FILS_NONCES=5D);=
=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0fils_params.fils_nonces_len=20=
=3D=20nla_len(info->attrs=5BNL80211_ATTR_FILS_NONCES=5D);=0D=0A+=0D=0A+=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0return=20rdev_fils_assoc_req_ies(rdev,=20d=
ev,=20&fils_params);=0D=0A+=7D=0D=0A+=23endif=0D=0A+=0D=0A=20static=20int=
=20nl80211_crit_protocol_start(struct=20sk_buff=20*skb,=0D=0A=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=C2=A0=20=C2=
=A0=20=C2=A0=20=20struct=20genl_info=20*info)=0D=0A=20=7B=0D=0A=40=40=20-16=
631,6=20+16666,16=20=40=40=20static=20const=20struct=20genl_small_ops=20nl8=
0211_small_ops=5B=5D=20=3D=20=7B=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0.doit=20=3D=20nl80211_set_wiphy,=
=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0.flags=20=3D=20GENL_UNS_ADMIN_PERM,=0D=0A=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=7D,=0D=0A+=23ifdef=20CONFIG_SCSC_WLAN_OCE=0D=0A+=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=7B=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0.cmd=20=3D=20NL80211_CMD_FILS_ASSOC_=
REQ_INFO,=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0.validate=20=3D=20GENL_DONT_VALIDATE_STRICT=20=7C=20GENL_DON=
T_VALIDATE_DUMP,=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0.doit=20=3D=20nl80211_fils_assoc_req_ies,=0D=0A+=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0.flags=20=
=3D=20GENL_UNS_ADMIN_PERM,=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0.internal_flags=20=3D=20NL80211_FLAG_NEED_NET=
DEV_UP=20=7C=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=C2=A0=20NL80211_FLAG_NEED_RTNL,=0D=0A+=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=7D,=0D=0A+=23endif=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=7B=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0.cmd=20=3D=20NL80211_CMD_GET_INTERFACE,=0D=0A=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0.valid=
ate=20=3D=20GENL_DONT_VALIDATE_STRICT=20=7C=20GENL_DONT_VALIDATE_DUMP,=0D=
=0Adiff=20--git=20a/net/wireless/rdev-ops.h=20b/net/wireless/rdev-ops.h=0D=
=0Aold=20mode=20100644=0D=0Anew=20mode=20100755=0D=0Aindex=202e497cf26ef2..=
000d2019901d=0D=0A---=20a/net/wireless/rdev-ops.h=0D=0A+++=20b/net/wireless=
/rdev-ops.h=0D=0A=40=40=20-1062,6=20+1062,20=20=40=40=20static=20inline=20i=
nt=20rdev_update_ft_ies(struct=20cfg80211_registered_device=20*rdev,=0D=0A=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0return=20ret;=0D=0A=20=7D=0D=0A=
=20=0D=0A+=23ifdef=20CONFIG_SCSC_WLAN_OCE=0D=0A+static=20inline=20int=20rde=
v_fils_assoc_req_ies(struct=20cfg80211_registered_device=20*rdev,=0D=0A+=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=C2=A0=20struct=20net_device=20*dev,=0D=0A+=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=C2=A0=20struct=20cfg80211_external_fils_assoc_p=
arams=20*params)=0D=0A+=7B=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0int=20=
ret;=0D=0A+=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0trace_rdev_fils_assoc=
_req_ies(&rdev->wiphy,=20dev,=20params);=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0ret=20=3D=20rdev->ops->set_fils_assoc_params(&rdev->wiphy,=20dev,=
=20params);=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0trace_rdev_return_int=
(&rdev->wiphy,=20ret);=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0return=20r=
et;=0D=0A+=7D=0D=0A+=23endif=0D=0A+=0D=0A=20static=20inline=20int=20rdev_cr=
it_proto_start(struct=20cfg80211_registered_device=20*rdev,=0D=0A=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0struct=20wireless_dev=20*wdev,=0D=0A=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0enum=20nl80211_crit_proto_id=20protocol,=0D=0Adiff=
=20--git=20a/net/wireless/trace.h=20b/net/wireless/trace.h=0D=0Aold=20mode=
=20100644=0D=0Anew=20mode=20100755=0D=0Aindex=20716a1fa70069..7c2877a7099b=
=0D=0A---=20a/net/wireless/trace.h=0D=0A+++=20b/net/wireless/trace.h=0D=0A=
=40=40=20-2256,6=20+2256,30=20=40=40=20TRACE_EVENT(rdev_update_ft_ies,=0D=
=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=C2=A0=20WIPHY_PR_ARG,=20NETDEV_PR_ARG,=20__entry->md)=0D=0A=20);=0D=
=0A=20=0D=0A+=23ifdef=20CONFIG_SCSC_WLAN_OCE=0D=0A+TRACE_EVENT(rdev_fils_as=
soc_req_ies,=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0TP_PROTO(struct=20wi=
phy=20*wiphy,=20struct=20net_device=20*netdev,=0D=0A+=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20struct=20cfg80211_ext=
ernal_fils_assoc_params=20*filsie),=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0TP_ARGS(wiphy,=20netdev,=20filsie),=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0TP_STRUCT__entry(=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0WIPHY_ENTRY=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0NETDEV_ENTRY=0D=0A+=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__dynamic_array=
(u8,=20kek,=20filsie->fils_kek_len)=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__dynamic_array(u8,=20ie,=20filsie->=
ie_len)=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0__dynamic_array(u8,=20nonces,=20filsie->fils_nonces_len)=0D=0A+=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0),=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0TP_fast_assign(=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0WIPHY_ASSIGN;=0D=0A+=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0NETDEV_ASSIGN;=0D=0A+=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0memcpy(__get=
_dynamic_array(kek),=20filsie->fils_kek,=20filsie->fils_kek_len);=0D=0A+=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0memcpy=
(__get_dynamic_array(ie),=20filsie->ie,=20filsie->ie_len);=0D=0A+=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0memcpy(__get=
_dynamic_array(ie),=20filsie->fils_nonces,=20filsie->fils_nonces_len);=0D=
=0A+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0),=0D=0A+=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0TP_printk(WIPHY_PR_FMT=20=22,=20=22=20NETDEV_PR_FMT=20,=0D=0A+=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=C2=
=A0=20WIPHY_PR_ARG,=20NETDEV_PR_ARG)=0D=0A+);=0D=0A+=23endif=0D=0A+=0D=0A=
=20TRACE_EVENT(rdev_crit_proto_start,=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0TP_PROTO(struct=20wiphy=20*wiphy,=20struct=20wireless_dev=20*wd=
ev,=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20enum=20nl80211_crit_proto_id=20protocol,=20u16=20duration),=
=0D=0A=C2=A0=0D=0A=0D=0A=0D=0A=C2=A0=0D=0A=0D=0A=0D=0A
