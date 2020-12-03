Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3E82CD4AA
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Dec 2020 12:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388226AbgLCLec (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Dec 2020 06:34:32 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:58328 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgLCLec (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Dec 2020 06:34:32 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B3BP1rE043123;
        Thu, 3 Dec 2020 11:33:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=xdtAb2apWwEWceU3YN9j4QOQVkpNJ3qjdii+mAZ0Md0=;
 b=D919YEG+QI9KU5pEa1nSmrJzg0xfZ2M88Bk44ZfSSnaTHP3xZ/xH8n5eyvyV/y6lbnK7
 VJUPT6tteAV/ll4JRFiFk05gXAvFVaWKpwdQdt3oCM/tQaBEwP8MEvCE5HYq8YyD0+CQ
 NOdkg8ceKou/wx+k+w36JpAYZ60mtl2pHf0uKOrwFOYz1owsoLt6FjUMwCb85XlF0jt2
 ik3J7o3U4n6FHv013Yj4QkD5ovdaFt2eo27OdRDjQWBNi4d32GL/yx6hUfhCq+nmhWub
 dxElwrA8aRL3+wev89T0BdYg6NGJtPpg/hJRXFSAye5kMdtNC9c/kPms293DfcLC3J+j ZA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 353egkwabs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 03 Dec 2020 11:33:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B3BPRBe066855;
        Thu, 3 Dec 2020 11:33:46 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 3540g1jt4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Dec 2020 11:33:46 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B3BXiQI001794;
        Thu, 3 Dec 2020 11:33:45 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Dec 2020 03:33:44 -0800
Date:   Thu, 3 Dec 2020 14:33:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] rtw88: debug: Fix uninitialized memory in debugfs
 code
Message-ID: <20201203113337.GL2789@kadam>
References: <X8ilOfVz3pf0T5ec@mwanda>
 <87pn3rgsgi.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pn3rgsgi.fsf@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9823 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012030070
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9823 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012030070
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Dec 03, 2020 at 11:16:29AM +0200, Kalle Valo wrote:
> Dan Carpenter <dan.carpenter@oracle.com> writes:
> 
> > This code does not ensure that the whole buffer is initialized and none
> > of the callers check for errors so potentially none of the buffer is
> > initialized.  Add a memset to eliminate this bug.
> >
> > Fixes: e3037485c68e ("rtw88: new Realtek 802.11ac driver")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/net/wireless/realtek/rtw88/debug.c | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> I'll take this to wireless-drivers, this shouldn't go to net.

Ugh...  The worst part about that is that I manually added the "net"
part without thinking thouroughly.  :/  Anyway, I've modified my QC
scripts now.

regards,
dan carpenter

