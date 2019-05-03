Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59A4F12BDC
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2019 12:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfECKtG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 May 2019 06:49:06 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:53336 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfECKtG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 May 2019 06:49:06 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hMVkT-0005mQ-QO; Fri, 03 May 2019 12:49:01 +0200
Message-ID: <315fea6071bc29c20b3f71f8e725433c64ad195d.camel@sipsolutions.net>
Subject: Re: [PATCH 5/6] rtw88: mac: remove dangerous while (1)
From:   Johannes Berg <johannes@sipsolutions.net>
To:     yhchuang@realtek.com, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 03 May 2019 12:48:58 +0200
In-Reply-To: <1556879502-16211-6-git-send-email-yhchuang@realtek.com> (sfid-20190503_123228_124010_1BC9DA36)
References: <1556879502-16211-1-git-send-email-yhchuang@realtek.com>
         <1556879502-16211-6-git-send-email-yhchuang@realtek.com>
         (sfid-20190503_123228_124010_1BC9DA36)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-05-03 at 18:31 +0800, yhchuang@realtek.com wrote:
> 
> +	while ((cmd = cmd_seq[idx])) {
...
> +	};

That semicolon is pretty pointless there :-)

johannes

