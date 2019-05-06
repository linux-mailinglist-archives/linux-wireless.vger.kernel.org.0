Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE071448A
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2019 08:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbfEFGn7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 May 2019 02:43:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48890 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbfEFGn6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 May 2019 02:43:58 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C57DB3086226;
        Mon,  6 May 2019 06:43:58 +0000 (UTC)
Received: from localhost (ovpn-204-123.brq.redhat.com [10.40.204.123])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6915560C44;
        Mon,  6 May 2019 06:43:58 +0000 (UTC)
Date:   Mon, 6 May 2019 08:43:57 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 5.1] rtw88: fix subscript above array bounds compiler
 warning
Message-ID: <20190506064357.GB5115@redhat.com>
References: <20190506062358.8288-1-sgruszka@redhat.com>
 <F7CD281DE3E379468C6D07993EA72F84D17EB2B5@RTITMBSVM04.realtek.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F7CD281DE3E379468C6D07993EA72F84D17EB2B5@RTITMBSVM04.realtek.com.tw>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 06 May 2019 06:43:58 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, May 06, 2019 at 06:32:01AM +0000, Tony Chuang wrote:
> > Subject: [PATCH 5.1] rtw88: fix subscript above array bounds compiler warning
> > 
> > My compiler complains about:
> > 
> > drivers/net/wireless/realtek/rtw88/phy.c: In function
> > ‘rtw_phy_rf_power_2_rssi’:
> > drivers/net/wireless/realtek/rtw88/phy.c:430:26: warning: array subscript is
> > above array bounds [-Warray-bounds]
> >   linear = db_invert_table[i][j];
> > 
> > According to comment power_db should be in range 1 ~ 96 .
> > To fix add check for boundaries before access the array.
> > 
> > Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
> > ---
> > RFC -> v1
> > - add check before accessing the array insted of
> >   rtw_phy_power_2_db() change.
> > 
> >  drivers/net/wireless/realtek/rtw88/phy.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/net/wireless/realtek/rtw88/phy.c
> > b/drivers/net/wireless/realtek/rtw88/phy.c
> > index 4381b360b5b5..9ca52a4d025a 100644
> > --- a/drivers/net/wireless/realtek/rtw88/phy.c
> > +++ b/drivers/net/wireless/realtek/rtw88/phy.c
> > @@ -423,6 +423,11 @@ static u64 rtw_phy_db_2_linear(u8 power_db)
> >  	u8 i, j;
> >  	u64 linear;
> > 
> > +	if (power_db > 96)
> > +		power_db = 96;
> > +	else if (power_db < 1)
> > +		power_db = 1;
> 
> I think it's "return 1" here.

Ehh, I missed that in your comment. However 'return 1' change
the output of rtw_phy_db_2_linear() quite substantially
as the smallest value (for power_db = 1) from db_invert_table[][]
is 10. I'll post v2 patch, but please double check it's indeed
correct logic. Thanks.

Stanislaw

