Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E879C97515
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 10:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbfHUIeG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 04:34:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40848 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727113AbfHUIeG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 04:34:06 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5704E3083391;
        Wed, 21 Aug 2019 08:34:06 +0000 (UTC)
Received: from localhost (ovpn-204-173.brq.redhat.com [10.40.204.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DEC7E60BF7;
        Wed, 21 Aug 2019 08:34:05 +0000 (UTC)
Date:   Wed, 21 Aug 2019 10:34:04 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Balakrishna Bandi <b.balakrishna@globaledgesoft.com>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/1] rt2x00: Queue flush fix
Message-ID: <20190821083404.GA20223@redhat.com>
References: <1566339185-11875-1-git-send-email-b.balakrishna@globaledgesoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566339185-11875-1-git-send-email-b.balakrishna@globaledgesoft.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 21 Aug 2019 08:34:06 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Aug 21, 2019 at 03:43:05AM +0530, Balakrishna Bandi wrote:
> Added rt2x00 queue flush fix and beacon frames checks.

Please post separate patch for each issue and provide
more descriptive information about the changes, especially
what problems are intended to solve.

> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800mmio.c b/drivers/net/wireless/ralink/rt2x00/rt2800mmio.c
> index 110bb39..9964371 100644
> --- a/drivers/net/wireless/ralink/rt2x00/rt2800mmio.c
> +++ b/drivers/net/wireless/ralink/rt2x00/rt2800mmio.c
> @@ -566,7 +566,7 @@ void rt2800mmio_queue_init(struct data_queue *queue)
>  
>  	switch (queue->qid) {
>  	case QID_RX:
> -		queue->limit = 128;
> +		queue->limit = 512;

How this is related with flush or beaconing ?

At this point of rt2x00 driver development I'm pretty reluctant to
increase queue size. But maybe we can do this for some particular
chip if things were tested on this chip and improve or fix something.

>  	if (!test_bit(DEVICE_STATE_PRESENT, &rt2x00dev->flags))
>  		goto exit_free_skb;
> +	/* Dirty hack for queue overrun protection,
> +	 * if AC_VO/AC_VI/AC_BE is full, use next queue.
> +	 * if AC_BK is full use previous queue.
> +	 */

No dirty hacks please.

>  void rt2x00queue_flush_queue(struct data_queue *queue, bool drop)
>  {
> +	unsigned int i;
> +	bool started;
>  	bool tx_queue =
>  		(queue->qid == QID_AC_VO) ||
>  		(queue->qid == QID_AC_VI) ||
>  		(queue->qid == QID_AC_BE) ||
>  		(queue->qid == QID_AC_BK);
> +	mutex_lock(&queue->status_lock);
> +	/* If the queue has been started, we must stop it temporarily
> +	 * to prevent any new frames to be queued on the device. If
> +	 * we are not dropping the pending frames, the queue must
> +	 * only be stopped in the software and not the hardware,
> +	 * otherwise the queue will never become empty on its own.
> +	 */

Since linux 5.2 there is rework done on related area. So maybe flush
issue you are trying to fix by this patch is already fixed. If not let
me know and provide description what is the problem.

> Disclaimer:- The information contained in this electronic message and any attachments to this message are intended for the exclusive use of the addressee(s) and may contain proprietary, confidential or privileged information. If you are not the intended recipient, you should not disseminate, distribute or copy this e-mail. Please notify the sender immediately and destroy all copies of this message and any attachments. The views expressed in this E-mail message (including the enclosure/(s) or attachment/(s) if any) are those of the individual sender, except where the sender expressly, and with authority, states them to be the views of GlobalEdge. Before opening any mail and attachments please check them for viruses .GlobalEdge does not accept any liability for virus infected mails.
> 

You should not sent this disclaimer to open mailing list.
Fix this or use different email service to post patches.

Stanislaw
