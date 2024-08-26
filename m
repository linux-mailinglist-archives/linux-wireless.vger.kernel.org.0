Return-Path: <linux-wireless+bounces-11988-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC50495F275
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 15:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8279B1F224E5
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 13:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BA117BEDB;
	Mon, 26 Aug 2024 13:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="sfkBm7uM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253FF17A5BE;
	Mon, 26 Aug 2024 13:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724677885; cv=none; b=TJfHCHKawzfgQedPdY2NScRRJmNhZuusorop4PSJu87rrQdhqJAVTj4NK/yB83YpEcZI0uSXDrQ0u12nJwIa3bNTzywTTJamWEhMG4NNwXa1SpaowOldQqq1IyGuyEybcLV8BrGK0FonT3+YRIh3ZhaaJTlZ2d/wa0O+mlxlFJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724677885; c=relaxed/simple;
	bh=p+GbYbWQASurqlY7OYug50PXJM/cMAlqIzI5g9Kq4O0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=IbCCS2ls8nDBzjFxMn91L44vdrotX/IsfW2O96GpMAQxmxb4qEu1VO+UhbF6BrWiyywyLmomB/GoCy7MKJ7u2o9DSDnHdRhwoxSBDzQNuvU4LaEVlynyaADhROtRh5MKxsa7PNWtpAA4zORSkB3UBF5ONHwsiMQeMCxxAcdIfbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=sfkBm7uM; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724677579; bh=2dPCyKhe8fcDZouwEAfvRfw2hnv3gQDexPZBNCHJStI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=sfkBm7uM+CeLJwZUhyuvHwygt7j21D9QERFTpbGNTKfNDy9qezEXMjo8ExNlwJTDd
	 u6bZfCo59/MHhisQ7r77+I2VlmSXnFSr3ToncJwPr5hVWzyb3/MVeSa2U/gRTjt8aX
	 2oumKYlH+/47bUkB+tumydp9Vn+jzFE/gG8l2fOY=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 19004E2A; Mon, 26 Aug 2024 21:06:16 +0800
X-QQ-mid: xmsmtpt1724677576toqo2nv2x
Message-ID: <tencent_5CE6CD937FE377496123A8A454F77F977805@qq.com>
X-QQ-XMAILINFO: OOWntbL6xj1693je7TqSVsqgZ6HX1JYPOgr+uKMjY8688GwqIrS6HlSypBHO+l
	 1Hkh0Rr6MZJ04KQC84P0EEzB+6iZ3/yRyWV/TmuapOhVO4ZC0GXTLzhls93iRDI7wTtVea+sUtDf
	 dj+KUA8FJyeiDgLzihU19mQCozhJPob1MC9az+Eg7qqOBpyLQ9ljoOEDRArK12P2t5vrhKnge3CM
	 NnIni72TnQJwTuLeqEvzmgy2ZrcwF4dl/6Iu2/96km/K55CNRzlqmEBnU9WbcLiRGYzRwlji94q4
	 GVcXpesRJHalMAStk2XHsifurMYAawaTQ0vFI0D3sR/VpJYkybyDVyiO3eecmaertSf7+kACD83A
	 lxW8JZmqsUqwk0O5I8u9ZEERKntbNhlNTrtV/l4qJCKfnPqP9Cve0O2WYrQz63WmENiTA5jyT9LL
	 i9lsbz2ZxHClt08Ug+fmvsLk7ZQjTUlHKqZ5c37uEhMUkGzf4v2P9ELt2Say2FFLQDv81nlzXMkN
	 BACkEycIrTPCpNu2N/kbLUriYQJqMK2/KsQ7NkAMSss1WWfiA+KyiTMLTVNVpTY8Vj/HTljaNNYv
	 mj/BUJYkYsUJC83UurVeLzxP3D6yJOycGLyFBF/eELx81CFRM+fRBQrIW3YIDvCm5h2RHdGj7eV7
	 bqw4nocwJaPHXcfx8EJlVXsnYH0Vu59sK+4+HhC7gZJ0soQhq3iZvPU31hSLkPWxWAOth4zKdyML
	 E0nGuUWkCOrdRn3z6EPvCl/7OhMGOD/RD1shy1yKfYVjbQlzpChxJx9ssgGnTNL9RuhwK/jsI2fI
	 3E4Ok4M+NS60hglIpUkAaEuZJ/h1xB3sLXlilonOKTZCjMi6F+fynENLAL2Pi76RZy24BNqpOUEU
	 jVQMC1jbsW3cSNC73w3E23y2AGqSJEPJGdwhDIK3RfvPPLncDp7vZO+PWCMOd2nZPl2Em5k6rqAl
	 E+36uFcP5Ine0WLltPaddIs5xN96ogZvHJtDRtRjDxKQ589+pO0PNxa2C/g+CPtvhg+uLZWUkaLr
	 uPQ9h6g2rMUGpYX30EcEL8QJewAQk=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: kvalo@kernel.org
Cc: eadavis@qq.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V2] wifi: ath6kl: Replace ath6kl_usb_submit_ctrl_in with usb_control_msg_recv
Date: Mon, 26 Aug 2024 21:06:16 +0800
X-OQ-MSGID: <20240826130615.2712119-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <87seurfr3r.fsf@kernel.org>
References: <87seurfr3r.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 26 Aug 2024 14:42:00 +0300, Kalle Valo wrote:
> > ath6kl_usb_submit_ctrl_in() did not take into account the situation where
> > the length of the data read from the device is not equal to the len, and
> > such missing judgments will result in subsequent code using incorrect data.
> >
> > usb_control_msg_recv() handles the abnormal length of the returned data,
> > so using it directly can fix this warning.
> >
> > Reported-by: syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> 
> Did you test this on real ath6kl hardware?
I don't have ath6kl hardware, I have only tested it on a virtual machine.

BR,
Edward


