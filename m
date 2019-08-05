Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B181981681
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2019 12:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbfHEKJw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Aug 2019 06:09:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57432 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727739AbfHEKJw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Aug 2019 06:09:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 402243082124;
        Mon,  5 Aug 2019 10:09:52 +0000 (UTC)
Received: from localhost (ovpn-204-27.brq.redhat.com [10.40.204.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 57F5F5DA60;
        Mon,  5 Aug 2019 10:09:49 +0000 (UTC)
Date:   Mon, 5 Aug 2019 12:09:47 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mt76: mt76x02u: enable multi-vif support
Message-ID: <20190805100947.GB17889@redhat.com>
References: <3edec94719a37a58576d530bba05dc629dfef2e0.1564750297.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3edec94719a37a58576d530bba05dc629dfef2e0.1564750297.git.lorenzo@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 05 Aug 2019 10:09:52 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Aug 02, 2019 at 04:36:20PM +0200, Lorenzo Bianconi wrote:
> Enable multi-interface support for mt76x02u driver. For the moment
> allow max two concurrent interfaces in order to preserve enough room
> for ps traffic since we are using beacon slots for it.
> I have successfully tested the following configuration:
> - AP + STA
> - AP0 + AP1

The combination that did not work in my testing was STA + STA .
This should be fixed or disabled.

Stanislaw
 
