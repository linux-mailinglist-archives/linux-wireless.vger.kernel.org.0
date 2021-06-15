Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789CD3A7E6C
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jun 2021 14:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhFOMza (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Jun 2021 08:55:30 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:12512 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230079AbhFOMz1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Jun 2021 08:55:27 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15FCqEAm019421;
        Tue, 15 Jun 2021 12:53:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=aploqCIcpWnVsbEPSdiKHfqPNxfuEd4QgUs/dMcsioY=;
 b=Oiu7wYjfIxRn3GpEO4DYiYX1U1PsPe+dLI+bzAR1bv4Cm+rc+JEMfMwa0L2FWb5NaIbA
 zTal2kEDdD+2J7gRmWP0c59E2PMAss82INnT73WhQ/JcI6Mpr8W3it78Vf8REyLbg8+E
 2bvFXqOPQ3crP4LD324oN7KjYQ9I5Ah/2RKubHRqCUG6OU6+oWX/dWK5AOE83D5oz7eK
 f+BmVw2c5gl3ecen0gSeBYHNBItt+XYzWuUEqaGldHFJXtrmDM70RuB6cSSGq/3wB8r4
 C3NyktOgu2MMcmfPO5qDN9fa1Bdnz/S6Xtkt322hjNLXcavce2n3g5WV1l/TnjFNj914 +A== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 395x06gjsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jun 2021 12:53:11 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 15FCrAIf125847;
        Tue, 15 Jun 2021 12:53:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 394j1ufyft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jun 2021 12:53:10 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15FCp1PM121957;
        Tue, 15 Jun 2021 12:53:09 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 394j1ufyfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jun 2021 12:53:09 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15FCr7dL021533;
        Tue, 15 Jun 2021 12:53:07 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Jun 2021 05:53:07 -0700
Date:   Tue, 15 Jun 2021 15:52:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Hans deGoede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] brcmfmac: fix a loop exit condition
Message-ID: <20210615125259.GB1901@kadam>
References: <YIKzmoMiTdToaIyP@mwanda>
 <20210615102656.DBB04C43143@smtp.codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615102656.DBB04C43143@smtp.codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: OqLDt2x4tzF4SkafUwDhpbc6VAgGyEGf
X-Proofpoint-GUID: OqLDt2x4tzF4SkafUwDhpbc6VAgGyEGf
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Jun 15, 2021 at 10:26:56AM +0000, Kalle Valo wrote:
> Dan Carpenter <dan.carpenter@oracle.com> wrote:
> 
> > This code is supposed to loop over the whole board_type[] string.  The
> > current code kind of works just because ascii values start 97 and the
> > string is likely shorter than that so it will break when we hit the NUL
> > terminator.  But really the condition should be "i < len" instead of
> > "i < board_type[i]".
> > 
> > Fixes: 29e354ebeeec ("brcmfmac: Transform compatible string for FW loading")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Reviewed-by: Matthias Brugger <mbrugger@suse.com>
> 
> There was talk about v2, but I don't see it in the patchwork.
> 

Ah, crap.  I started to debug Smatch to find out why it wasn't warning
about some of these bugs and I got a bit carried away writing Smatch
code and forgot to come back to this.

I will send it tomorrow.

regards,
dan carpenter
