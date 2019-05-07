Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 991F6163CB
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2019 14:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfEGMgK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 May 2019 08:36:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58698 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbfEGMgK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 May 2019 08:36:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B035930821A3;
        Tue,  7 May 2019 12:36:09 +0000 (UTC)
Received: from localhost (ovpn-204-114.brq.redhat.com [10.40.204.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C02564050;
        Tue,  7 May 2019 12:36:07 +0000 (UTC)
Date:   Tue, 7 May 2019 14:36:07 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        pkshih@realtek.com
Subject: Re: [RFC] rtlwifi: rtl8821ae: Use inline routines rather than macros
 for descriptor word 0
Message-ID: <20190507123606.GA5076@redhat.com>
References: <20190506173916.16486-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506173916.16486-1-Larry.Finger@lwfinger.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 07 May 2019 12:36:09 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, May 06, 2019 at 12:39:16PM -0500, Larry Finger wrote:
> The driver uses complicated macros to set parts of word 0 of the TX and RX
> descriptors. These are changed into inline routines.

Why not use le32p_replace_bits() like rtw88 in 
drivers/net/wireless/realtek/rtw88/tx.h ?

Stanislaw
 
