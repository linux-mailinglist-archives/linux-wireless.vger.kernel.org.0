Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84DE7BC0C6
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2019 05:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394554AbfIXDia (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Sep 2019 23:38:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56068 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391692AbfIXDia (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Sep 2019 23:38:30 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 153A8602F2; Tue, 24 Sep 2019 03:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569296309;
        bh=Ua6L2aRvDvQV9DfCgeqBlGXZkWiA8wsqvrMqezzm0hE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OUBcc2hkLJj9vjBpk4T00hRhGA1727TWZIyX9jpAesnSzX1zXazhB9MVdfO35nsel
         oR72nC4s1k0Gc/oKJPiZybu7yDw6LRJmtp972SHYtE3zJyL7m6xFW6OPoBirrszWDz
         521N4CaCX5EUJnrj0MGXS2Fobiry7002QlFWuX3U=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 9477160274;
        Tue, 24 Sep 2019 03:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569296308;
        bh=Ua6L2aRvDvQV9DfCgeqBlGXZkWiA8wsqvrMqezzm0hE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RQwnyFupPHculz0D1dmCaG1ra/ac1emNbtRQvjgnPBvsdK7KFRDxvv97rL7j7NZIl
         3KOUwnAK0gvQMkdnnOXqcPhlU+KhiqCM3wqJtBR9Ds+YxgC2zgxhc7SoFPBOW7wd20
         IV7jpBahIFiX21lR/euBVEW+d/3FKOJPgdptVwjg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 24 Sep 2019 11:38:28 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] ath10k: add fw coredump for sdio when firmware assert
In-Reply-To: <706142499b2f13de278262f3c52c2047@codeaurora.org>
References: <1567132338-7407-1-git-send-email-wgong@codeaurora.org>
 <878sqhc25h.fsf@codeaurora.org>
 <706142499b2f13de278262f3c52c2047@codeaurora.org>
Message-ID: <3e189b030590e1f73acefb9ba111a184@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

patch v3 sent.
https://patchwork.kernel.org/patch/11156663/
https://patchwork.kernel.org/patch/11156659/

