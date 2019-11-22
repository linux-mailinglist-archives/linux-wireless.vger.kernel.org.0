Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEC72107243
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 13:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfKVMiQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Nov 2019 07:38:16 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57720 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfKVMiP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Nov 2019 07:38:15 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAMCTgsP020019;
        Fri, 22 Nov 2019 12:37:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=RXHpNXKeSFhWszqKE2zK8QQG9WChzlwgrOViGlZ02zc=;
 b=CwtxpArJV+n9Fsk69XER5H9LDkFNVK9jh8cH5hb0LbLClW2clxVS/iclGrALrdPnhqdZ
 gcWnzevPB3QNQKC/cqZEVRWWYr8xOYgte+Tl17DoNg3xru+QKKxQ/Z+Pjhm7JmkvHR0F
 JD4ZIE0GhzybPnieBs2pROfMEqVFsKGym0w2S5gZPASA6WE9v0xqq2TgE13WwXKVdkMB
 JZHbFKatpVSNjFaGYGjygVBMJRpg/cItJYiSTXg8KvyHZWY5miwGTOqGezHd8VAQ0mQi
 08VaBxMlGK2je9Va6Tltd3vtCcM2tPRFPrzEHyuXD/qxewcN2MqaIF3cvIfbt9obX0qo ww== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2wa8huabcc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Nov 2019 12:37:53 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAMCT6sB082276;
        Fri, 22 Nov 2019 12:37:52 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2we8yftgwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Nov 2019 12:37:52 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAMCboEZ028482;
        Fri, 22 Nov 2019 12:37:50 GMT
Received: from kadam (/41.210.159.99)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 22 Nov 2019 04:37:49 -0800
Date:   Fri, 22 Nov 2019 15:37:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ganapathi Bhat <gbhat@marvell.com>
Cc:     qize wang <wangqize888888888@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        amitkarwar <amitkarwar@gmail.com>,
        nishants <nishants@marvell.com>,
        huxinming820 <huxinming820@gmail.com>,
        kvalo <kvalo@codeaurora.org>, Greg KH <greg@kroah.com>,
        security <security@kernel.org>,
        linux-distros <linux-distros@vs.openwall.org>,
        Solar Designer <solar@openwall.com>
Subject: Re: [EXT] Re: [PATCH] mwifiex: Fix heap overflow in
 mmwifiex_process_tdls_action_frame()
Message-ID: <20191122123739.GJ617@kadam>
References: <E40E893E-D9B4-4C63-8139-1DD5E1C2CECB@gmail.com>
 <20191122111339.GH617@kadam>
 <MN2PR18MB26373BC0C0D63A7C3CE09FC4A0490@MN2PR18MB2637.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR18MB26373BC0C0D63A7C3CE09FC4A0490@MN2PR18MB2637.namprd18.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9448 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911220112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9448 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911220112
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Nov 22, 2019 at 11:40:40AM +0000, Ganapathi Bhat wrote:
> Hi Dan,
> 
> > > +			/* copy the ie's value into ht_capb*/
> > > +			memcpy((u8 *)&sta_ptr->tdls_cap.ht_capb, pos + 2,
> >                                                                  ^^^^^^^
> > 
> > I don't understand why we changed "pos" to "pos + 2".  Presumably there is
> > a reason, but it needs to explained in the commit message.
> 
> I think, we were doing wrong in the original code. We are supposed to use 'pos + 2' itself, instead of just 'pos'. This is because, 'pos' is pointing to 'ieee_types_header', followed by the actual data and the destination do not start with (i.e. it do not contain) 'ieee_types_header'(ex: 'sta_ptr->tdls_cap.ht_oper').
> 
> Also, there are few places were the destination starts with 'ieee_types_header'(ex: 'sta_ptr->tdls_cap.extcap'), which need just 'pos'.

I assumed it was something like this but it needs to be explained in
the commit message.

regards,
dan carpenter

