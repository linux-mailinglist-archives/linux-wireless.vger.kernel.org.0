Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3279A3BDD87
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jul 2021 20:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbhGFSvM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jul 2021 14:51:12 -0400
Received: from mr85p00im-ztdg06021201.me.com ([17.58.23.189]:47819 "EHLO
        mr85p00im-ztdg06021201.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230084AbhGFSvL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jul 2021 14:51:11 -0400
X-Greylist: delayed 581 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Jul 2021 14:51:11 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1625596731;
        bh=YeNwZ6xjjsQzfv3w5k6wuw9z97y58iSFhubwbj+BkNw=;
        h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
        b=x2HOf8syJJzCTNqrBwVqqfKFsbz+PsIxtPDhEUpdrn44nzzKMmHz+EX0GRDEVim7+
         k+WVhEcDnazkeCK983mg5da2b1DqU2wb250hcJXf4pZTrYMEO0If6z2pWrv0FsOSmt
         /ezIWAeZ7KYU5ZY0bYFSDiS79p+SQ5DqNdHbd6RIkks37YRyCq/aLSeJNL4VXqOOAo
         iFCPPz9L+cLyPQnrsHFqkmqeGJLw99MeTTU79vmqP5/v6LFghnN5sJbsmfoRApqwXU
         7rySEIHpCTchTtLL+mrnod4eOCOPUATT1ig098rptDNrWyZ0VCZ1Y7+oN4KKqyxDPq
         kssZA1D7/DZPQ==
Received: from smtpclient.apple (199.sub-174-205-64.myvzw.com [174.205.64.199])
        by mr85p00im-ztdg06021201.me.com (Postfix) with ESMTPSA id 1AD9F1201A1;
        Tue,  6 Jul 2021 18:38:51 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Stephen Hemmes <playdate4you@icloud.com>
Mime-Version: 1.0 (1.0)
Date:   Tue, 6 Jul 2021 11:38:49 -0700
Subject: Re: [PATCH] net:wireless: call cfg80211_leave_ocb when switching between ADHOC and OCB
Message-Id: <155485B2-322B-4C6C-B25D-B70AE0EF22D5@icloud.com>
Cc:     gregkh@linuxfoundation.org, johannes@sipsolutions.net,
        linux-wireless@vger.kernel.org, skhan@linuxfoundation.org,
        syzbot+105896fac213f26056f9@syzkaller.appspotmail.com
To:     ducheng2@gmail.com
X-Mailer: iPad Mail (18F72)
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.391,18.0.790,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2021-07-06=5F10:2021-07-06=5F01,2021-07-06=5F10,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=642 bulkscore=0
 suspectscore=0 spamscore=0 phishscore=0 clxscore=1011 malwarescore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2107060087
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dude WTF is this and why is it in my computer? 

Sent from my iPad
