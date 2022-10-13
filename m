Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5EC5FD9CE
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Oct 2022 15:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiJMNFA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Oct 2022 09:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiJMNE6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Oct 2022 09:04:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8CD183B1
        for <linux-wireless@vger.kernel.org>; Thu, 13 Oct 2022 06:04:54 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29DD0mdV010159;
        Thu, 13 Oct 2022 13:04:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2022-7-12;
 bh=Uht0BU2hbbKbFDM7033dO8/KbMGl7ogGJ9MkdrDZfLc=;
 b=bllKwkvY0ANx13eokC450RINoyafxpu/rdz/4GsD6kst1COf2iluvfyBCSGoRZetFH13
 YXFs58M2ckIrjMnkcZJa8Z4co4yPcouHuicRSbhFUhW+nxNY29IZUd36dXxk2hnCvL4o
 eKC+ZjbCbryFjvph23odl9teMocVH9QkMbn3qS4C1+YhpnaBMzre0OC2R0+JQzHvc2tC
 rMUNi/gYU84wgo0QtpRB6eut6nxCTQ782DTl08PjL+umalEopZ/camLjvnsTH/y0Z0YZ
 ZEirAF+/w+nt4dKh13RsAExNCejzfzzChKMW3q0pygG8XrfWbIgPTOXDRcbnxOiGnNva Mw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k62bshx4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Oct 2022 13:04:43 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29DAwZqg018222;
        Thu, 13 Oct 2022 13:04:42 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yn65khx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Oct 2022 13:04:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZMjYAypJfKSfoFYOWQfuTmFL3oQYUpu0kHaXr0eDs+JYHG7bQwZsHMVNWtz7FLV0oEdtmAh/B009gBWyA41Fmg4nbgUArsJle12P0J9I3L51OLjMIyBJIHh9rY51/VeAl7Ywh3YOD0PjWkMb7HtbgtDB4Wt9MUWa4PXAyUYYrjBFhuNhXHTko03RwsCUTNhvY4id3CTuQIXXRD2+5OTwjxDQptBKCIR2SSMiPrTrRzAoJSesJ9UmouURNpVNI7tzauoQbyMdSiRYL5IU7rXBQEmzhSNr6b6A6lgD6IXM+Sbior3SB4NF1Q8MQ3mP/aCZef4i4Xg6k964xkU/va0YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+fgoGYhJiTs3MwUCLrJw2t2IUKiUrBVteja04a2nug=;
 b=M67FsH3r5BDS7LYDm5ThfwHEhdqC+vl1sOrAR6vmImYaE+WCYJH1Clpi1K812542V0xEzlim/eRxlUEVxNMdQgTKs7HjRmlqc/vj55HQJ4QF4M6aHfuZ355w48LY/5t+ZjHU5u8a2oBQoknTFUB6XsibVeRMBTVOkFx6rkggJWgl9MMavhfl+YQGZhHnu0Exsa4/lhtcPqBNxJUn/B4vo/NM6IVSGiGZNtgeONUWySdayj2FcX/1WKauXBOB79xEo3kfMetsPIvJLj14rl4odCb4MqQ24fHHAnOhJngFQJmsi3nitBCn6AUAMz4wuI8UZD/YeifQ41eDXliw72YP3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+fgoGYhJiTs3MwUCLrJw2t2IUKiUrBVteja04a2nug=;
 b=lxM78WB6kVe5EV4B/NLNeEsGTmHcSrdZdNGoKn0nBOQv/vAWmwpP4i+RFtNnQmgsR18YWfdBAgzyczkGynrLd/kT4nQQaKiON5owZoupDTYb4SJejZvtB9ZA5fzM98Xux60OYkBv0EpkiR2N4WKCPQaP/FEtgQIjUx1xjF3/7f8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN0PR10MB5080.namprd10.prod.outlook.com
 (2603:10b6:408:114::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 13 Oct
 2022 13:04:40 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Thu, 13 Oct 2022
 13:04:40 +0000
Date:   Thu, 13 Oct 2022 16:04:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [bug report] mt76: implement functions to get the response skb
 for MCU calls
Message-ID: <Y0gM2jeo/X5Vq+lq@kadam>
References: <20211008130007.GA23161@kili>
 <9298fd82e4b49b965e9f26957510b9e968e8b691.camel@sipsolutions.net>
 <20211008142734.GI2083@kadam>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211008142734.GI2083@kadam>
X-ClientProxiedBy: JNAP275CA0019.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::23)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|BN0PR10MB5080:EE_
X-MS-Office365-Filtering-Correlation-Id: 1828578c-9ee8-43a7-6534-08daad1b7c84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: znHYm/zVzn8nUHLpmhPIbvqTwy0bjPk/8/lYNxEsyczeywO/rQQN2m8+G0hYpa1wZiEaoKXEbI2bGzmZRhwCj+9dcjQ2YZw4vslQ8N9KINE6DwjToj5UjBGVV6saK3wBeBR/lN+Ekbpp3FWyVivbRQqdh5KxSNAYK58kRzq/WjPrq8UxuXE2qNQN1hjYzpndnW9rzq8CAm4/CBFvFthZjRtjLsCG57b/SAJXKNPT5bIP3mg2nLQ9oRXuOqV3fCdtecy9LY3q8tC/8ooFgFiIu17GKgR80Ek8+8eItmeFxpNZU6fNfiUoq4WHKTalSF9QYjG1ztEXktxOCCvhJKL8IZZiuSQVPkE3Rx8oauUQcjPE12qomAYBqjR3PsILU17JssBmEBezI52T66Jfzvn1UwQBAKZjCIVGxAl3I9UyhsSTdkFvV2wldspEZzPCl9lJm4LtV5/IIPuneHxZNWPxOZl4Y4A8cg02zmQmQ+wIRL6JHARH69btQQSOmwmQyup4ou5J8nEb2WRKbKH7pnQ/4PLY8XZ9WckjG9qhjLbu4TH7HNbcKQDZPOgGDXX1TFgghaMLtASoX/TQn2FwqSlVW3vU0Yvzjt+xRXwdm+fBsf4MfVhr0GeaKfUNM1rSriUfAv+MvOp84UveV0+Uun5UepAI6vrYJ6SpkWdXnfWborXyHS6131HhLQSMdrzXneF3SY9RO0WRhs1jD1WRXU18vE4axzvuJryoZ76lWOd37Z+Uz/zUrVuL7rKkIPS7rrgp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199015)(33716001)(6506007)(316002)(6512007)(4326008)(9686003)(83380400001)(2906002)(8676002)(26005)(110136005)(41300700001)(38100700002)(44832011)(8936002)(5660300002)(186003)(86362001)(66556008)(66476007)(6486002)(478600001)(66946007)(6666004)(15583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?JjGi7HCFiXPIxq3ZHBVbpmbKBJ8RNWWIqc4sdIySw+Lkn/huSpCFEHsHVV?=
 =?iso-8859-1?Q?GG6Kz+KN9RiSmqI8/GY5KtAiJQ2RpeK7hGx1j917eWSVJuCy/9W6CBpczH?=
 =?iso-8859-1?Q?dVbsZ91EFX3JAp2GULYRQhhX2zTvxf83IOeN0mA5MJA8+WJCQUpWkC17+F?=
 =?iso-8859-1?Q?k8ZQCw3vzyH/D9ufTR8QQA7rXEFs6X+BO/7UrrwUxOU7u/fnHfKfUta3aR?=
 =?iso-8859-1?Q?tL2w7JCbfpJW8efKMoy/YbLoYqQL0i8WY5LK/N5cGXCgmZR/3qnC+ayqJL?=
 =?iso-8859-1?Q?Er0n3OpgV55tU9VDRBfRDXx5zLHLjnbkh8tLi01SFwRy6qosAPQSIS4DfO?=
 =?iso-8859-1?Q?unpnLXGPyuz45UXdXo/3MJ+PsQN9f0DEcR5YqnPefEDCmXYvxV8cTidw19?=
 =?iso-8859-1?Q?kmW0P5gVz1XdWVihjQzF4U3OH/g3DhYW6frRAL0PZI1GV1T0D23wxEfNcF?=
 =?iso-8859-1?Q?2OWBHEUflrX0olSIo/rkIkePxu4QccFJwNANkBGX+tNPSpRdwZVUMFSc30?=
 =?iso-8859-1?Q?ZUD49E9DgZcvTp2Ioq5mzJk03891sc75WQj1hCqfoptSo7FP+0hzOcY5U1?=
 =?iso-8859-1?Q?zSIZb3h5llIJzEYvY3sz1kcOq0XlQLMKAHhlPIUtlmY5FkDlsCJ4pfrGsQ?=
 =?iso-8859-1?Q?2qne4Yj047IJ6Ntoe1NKQ3jsrXLAzPG2DyB2KkyAmSfFgcrKBr7LSe6STI?=
 =?iso-8859-1?Q?AV3QaszoekBmN+9GNN97X/h9J4fSHBIhrc3d/g/JrWUUXmhK3NeTgvY+34?=
 =?iso-8859-1?Q?niIi0ru8/vPkesVL2VSssrNMY83CZuvAvgnpzwFCFHi3u87r2lKrRgRFU4?=
 =?iso-8859-1?Q?Qqtz3ze+i2UZZ3HmkRTfaXbZNQjkJCLOiVh06GBctjU6qlfM+cpaPJUE0k?=
 =?iso-8859-1?Q?0nHx04twYQf+zQ8IMi7U54P5Gs530pl/eQERj4Hg7qaZP/rr2UxizmPgAs?=
 =?iso-8859-1?Q?auG32LlvFoFWFxZ1aK69P3bvGcghH7iOIPviCYrJypq8NuLixOjgsvIGOB?=
 =?iso-8859-1?Q?CH3dih/RGcl5pfSnBfkCsFiO2Rza011i66dFQSwGs6oSTapeY1uw59i2SC?=
 =?iso-8859-1?Q?MbiDIVZF0RCC1oCw7hNHDfpyOXLz3PdWh8Luo6MexCrJFsvSwHbgvuKmKO?=
 =?iso-8859-1?Q?Wog8tuUChbjAJuS4uHln+NpYZZxAqxkScqwSTU5+F4LHkwofFFK2YJqVPw?=
 =?iso-8859-1?Q?2rUnRSGhrOkzSsmFPgzgSQGNbCYzU9kJrUz6Yuka//MARWjstMgV8WXIss?=
 =?iso-8859-1?Q?XmkegkfmkmJp5L+/Aa6qW+uBCUh/ktJRP383jZm+8581f6Wc37j3mNA6NP?=
 =?iso-8859-1?Q?COm+MqjFXmVCct7BoGP6LwjfKMkXUTLjaSmDELggtnmi+nKCx5yVWXXp2B?=
 =?iso-8859-1?Q?fOyvmzcQ40EsTW9PnQdPUI9TpK3eG2CcTTS+dq/VxaD/YuzmbmblLtTua5?=
 =?iso-8859-1?Q?K06Vjlc2I8N4NG7i3IKDETwqGYvQXXsdZUFYlF9M2xfNk9RE9eKiNPH6jo?=
 =?iso-8859-1?Q?qjs5bAzH1o6F9ivLWb52p8yHs8cWV/hxFOq4OAkpHIkBkN7tn5Yddnl6L4?=
 =?iso-8859-1?Q?ywOThpa/tzvBe5H/PM6LrsSIkQ+aTmOgkjwagZhL+auQRE9tD4mBRWgWM6?=
 =?iso-8859-1?Q?dsQIRkGuRyQtQRM1OA1s6GCOq5+Qdd1teb2UuCpC9ypU42DdCAQv3j1A?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1828578c-9ee8-43a7-6534-08daad1b7c84
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 13:04:39.8775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zwK8J2r/08XHdldR5e601J1xrd3EBoprGb4eMGnU1TiarrKtmnIvyg3OAGswJNuk7p3uWd+J+cjVdPehkJnMib7HUxL/uJEqamz6a6nP6Jk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5080
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-13_08,2022-10-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210130078
X-Proofpoint-GUID: vv_KHkrrTDMcla4IESyykB9ZwyRyCOlP
X-Proofpoint-ORIG-GUID: vv_KHkrrTDMcla4IESyykB9ZwyRyCOlP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I would like to revisit this question.  Last time I complained about
this Johannes responded but he misread what mt76_mcu_send_and_get_msg()
does.  I have looked at it as well and I also cannot explain what is
going on in that function.

I have looked at the callers and my first instinct is that maybe this
is dead stub code?  But then when I look at mt76x02u_mcu_send_msg() I
think "No, this is not stub code.  This should be returning the newly
allocated skb to the caller."

But then I think, surely at some point someone tested this code???  It
must be stub code.

Could we get some clarity on this?

regards,
dan carpenter

On Fri, Oct 08, 2021 at 05:27:35PM +0300, Dan Carpenter wrote:
> On Fri, Oct 08, 2021 at 04:03:10PM +0200, Johannes Berg wrote:
> > On Fri, 2021-10-08 at 16:00 +0300, Dan Carpenter wrote:
> > > 
> > >     1146         ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_EXT_CMD_EFUSE_ACCESS, &req,
> > >     1147                                         sizeof(req), true, &skb);
> > > 
> > > If mt76_mcu_send_and_get_msg() calls the dev->mcu_ops->mcu_send_msg()
> > > then "skb" is not initialized.
> > > 
> > >     1148         if (ret)
> > >     1149                 return ret;
> > >     1150 
> > > --> 1151         res = (struct mt7921_mcu_eeprom_info *)skb->data;
> > 
> > Looks like possibly 'skb' is always initialized if
> > mt76_mcu_send_and_get_msg() returns 0 (success)?
> > 
> 
> This build is with cross function analysis enabled so Smatch looks for
> that.
> 
> The problem is that the caller has to know if dev->mcu_ops->mcu_send_msg
> is NULL or not because if it's non-NULL "skb" is not set.  Perhaps that
> means it should be separated into two functions and we pick which one
> to call depending on whether the pointer is set.
> 
> drivers/net/wireless/mediatek/mt76/mcu.c
>     54  int mt76_mcu_send_and_get_msg(struct mt76_dev *dev, int cmd, const void *data,
>     55                                int len, bool wait_resp, struct sk_buff **ret_skb)
>                                                                                 ^^^^^^^
> This is the parameter.
> 
>     56  {
>     57          struct sk_buff *skb;
>     58  
>     59          if (dev->mcu_ops->mcu_send_msg)
>     60                  return dev->mcu_ops->mcu_send_msg(dev, cmd, data, len, wait_resp);
> 
> The function pointer doesn't set *ret_skb at all.
> 
>     61  
>     62          skb = mt76_mcu_msg_alloc(dev, data, len);
>     63          if (!skb)
>     64                  return -ENOMEM;
>     65  
>     66          return mt76_mcu_skb_send_and_get_msg(dev, skb, cmd, wait_resp, ret_skb);
> 
> But this does.
> 
>     67  }
> 
> regards,
> dan carpenter
