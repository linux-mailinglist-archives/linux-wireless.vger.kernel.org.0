Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23D9356A5D
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2019 15:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfFZN03 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jun 2019 09:26:29 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52968 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfFZN03 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jun 2019 09:26:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QDOI5i040624;
        Wed, 26 Jun 2019 13:25:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Jc6Kfrqo1obGKGX3hptI4aB5JIAaOzHxGxab76hqajY=;
 b=LrUnKJ1MjOtfc/B1JoNi+K6yg7FYvyTYxDiBN5Y644tafzbpJeUoz/5ikBTb2eyTqDwI
 5iSXrYGFZ6LhH35+9v3IUc+DT4xTWeTHgp6dZK7aQ8uV9OfWljf/q3Vz97ND6rOSWulv
 BaPCVEbu4BSvdUYM91GbNQfBGywSeuK1WC8+VlDEXs9hYg4Wt0HTQhSEufC4M+AQwZch
 YXfwNSq30U2BXkSByfQm9/ZEeR4uuu/xY2Sj+f37p8DZuVpSPHcTJfnLx85Xs3fyLNj1
 FrgJ8kIadtNbCGJ3SqiP4VUUrpNI8te1tOwy4XOQyWQH7yJ6qYk8290nOvIjOAVPhqT2 zQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2t9cyqj8n4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 13:25:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QDNRmo136851;
        Wed, 26 Jun 2019 13:23:56 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2tat7cttk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 13:23:56 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5QDNmTr019550;
        Wed, 26 Jun 2019 13:23:49 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Jun 2019 06:23:48 -0700
Date:   Wed, 26 Jun 2019 16:23:40 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Dan Williams <dcbw@redhat.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Philip Rakity <prakity@yahoo.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        kernel-janitors@vger.kernel.org, linux-wireless@vger.kernel.org,
        Allison Randal <allison@lohutok.net>,
        libertas-dev@lists.infradead.org
Subject: Re: [PATCH] libertas: Fix a double free in if_spi_c2h_data()
Message-ID: <20190626132340.GE28859@kadam>
References: <20190626100926.GD3242@mwanda>
 <be491ab35ba46111a1c90cc12b6d5ff6ea3f57e8.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be491ab35ba46111a1c90cc12b6d5ff6ea3f57e8.camel@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=563
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906260160
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=615 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906260160
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yeah.  That looks nicer.  Could you send it as a proper patch and give
me Reported-by credit?

regards,
dan carpenter

