Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56E7556E43
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2019 18:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfFZQCZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jun 2019 12:02:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35084 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfFZQCZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jun 2019 12:02:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 62B853087930;
        Wed, 26 Jun 2019 16:02:22 +0000 (UTC)
Received: from ovpn-112-45.rdu2.redhat.com (ovpn-112-45.rdu2.redhat.com [10.10.112.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F78D5D9C6;
        Wed, 26 Jun 2019 16:02:20 +0000 (UTC)
Message-ID: <e679c9f99d6952f82924c71f036e4a196d0e72d4.camel@redhat.com>
Subject: Re: [PATCH] libertas: Fix a double free in if_spi_c2h_data()
From:   Dan Williams <dcbw@redhat.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Philip Rakity <prakity@yahoo.com>,
        libertas-dev@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-wireless@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Kalle Valo <kvalo@codeaurora.org>,
        Allison Randal <allison@lohutok.net>
Date:   Wed, 26 Jun 2019 11:02:19 -0500
In-Reply-To: <20190626132340.GE28859@kadam>
References: <20190626100926.GD3242@mwanda>
         <be491ab35ba46111a1c90cc12b6d5ff6ea3f57e8.camel@redhat.com>
         <20190626132340.GE28859@kadam>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 26 Jun 2019 16:02:25 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-06-26 at 16:23 +0300, Dan Carpenter wrote:
> Yeah.  That looks nicer.  Could you send it as a proper patch and
> give
> me Reported-by credit?

Will do.

Dan

