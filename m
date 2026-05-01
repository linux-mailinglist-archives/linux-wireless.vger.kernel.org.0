Return-Path: <linux-wireless+bounces-35750-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uL8LDr6x9GnTDgIAu9opvQ
	(envelope-from <linux-wireless+bounces-35750-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 01 May 2026 15:59:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D64634ACF7C
	for <lists+linux-wireless@lfdr.de>; Fri, 01 May 2026 15:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24B03303DAA6
	for <lists+linux-wireless@lfdr.de>; Fri,  1 May 2026 13:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5723BFE2A;
	Fri,  1 May 2026 13:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hacn9ZH5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B163BED6E;
	Fri,  1 May 2026 13:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777643840; cv=none; b=r5tPuy/Je/cVfxiU9/hKvDERFcK1xnmvtmZBHuM9yGPt2HwyUssPOb4ZVngybvesvU3ctSQXDiQnIh42lcgxQAFW4utPLHa6JqG96sLhMNez1+7TVluK3sPMD8/uEy3PgztWMyt8CKI6d79SI73UmrlVLbmqGnjsuHQq/qtXBRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777643840; c=relaxed/simple;
	bh=w8gK0qhyZPCNHIhL7IgT046DTvz68t7gU8GMkEECV+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z04C1wtY7ITA97I2jWMQPCc1p7XDdO7XNmu04xg3mfT1uk8c9SiDu4cF1EDU1RXrEGTNSNx6JtfTYf0O7oeyVXL8+Nv3J6TRzS+FiY/kIk4RzwF2X440pxgUdx31//ZB3piDB2IkiYMlXF+yG0HczFZAHgWGb6HVkbBgcjhny9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hacn9ZH5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505D0C2BCB4;
	Fri,  1 May 2026 13:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777643840;
	bh=w8gK0qhyZPCNHIhL7IgT046DTvz68t7gU8GMkEECV+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hacn9ZH5LTvmUEB+PI0lanXZ2FDkaV/k8AvcTqlgzHo2Nh8mDkG32yuYesG/z9/xt
	 tiNfGbgRgtdPkDbgn2sbCJBYPBXSntkFP+Ciuprfd/oGtJ6P2+UHYgiARxi/2eHq12
	 l72dxRCf48OjqnJJQyxceie8uFZFzjk6iNYmYw2vGMkp5M9P6An69nQwYf3yqaV9v7
	 l+ZerbetJ1RzM9cIp+KXtSXFmPn5WyK1Jfkvopr7Ig61kDhQH4KUTaG9L5eOapl4TL
	 SPBkZw05fHoJZpexPjP2QnrP1gpwZoagmU7iYmrssHTVQ3syTqab3G/5xZSJVQHbcP
	 rEdHxzf5ICJww==
Date: Fri, 1 May 2026 19:27:03 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-media@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
	linux-remoteproc@vger.kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	robin.clark@oss.qualcomm.com, sean@poorly.run,
	akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
	jesszhan0024@gmail.com, marijn.suijten@somainline.org,
	airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
	dikshita.agarwal@oss.qualcomm.com, bod@kernel.org,
	mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org,
	trilokkumar.soni@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
	jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
	vignesh.viswanathan@oss.qualcomm.com,
	srinivas.kandagatla@oss.qualcomm.com,
	amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
	op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
	skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v4 05/15] remoteproc: qcom_q6v5_pas: Switch over to
 generic PAS TZ APIs
Message-ID: <afSxLxDPHh6Ajpi6@sumit-xelite>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-6-sumit.garg@kernel.org>
 <20260429132512.aki4vqkhpil7awc3@hu-mojha-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429132512.aki4vqkhpil7awc3@hu-mojha-hyd.qualcomm.com>
X-Rspamd-Queue-Id: D64634ACF7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35750-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumit.garg@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Wed, Apr 29, 2026 at 06:55:12PM +0530, Mukesh Ojha wrote:
> On Mon, Apr 27, 2026 at 03:25:53PM +0530, Sumit Garg wrote:
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > 
> > Switch qcom_q6v5_pas client driver over to generic PAS TZ APIs. Generic PAS
> > TZ service allows to support multiple TZ implementation backends like QTEE
> > based SCM PAS service, OP-TEE based PAS service and any further future TZ
> > backend service.
> > 
> > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > ---
> >  drivers/remoteproc/qcom_q6v5_pas.c | 51 +++++++++++++++---------------
> >  1 file changed, 26 insertions(+), 25 deletions(-)
> > 
> > diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> > index da27d1d3c9da..847249c28c1b 100644
> > --- a/drivers/remoteproc/qcom_q6v5_pas.c
> > +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/pm_domain.h>
> >  #include <linux/pm_runtime.h>
> > +#include <linux/firmware/qcom/qcom_pas.h>
> >  #include <linux/firmware/qcom/qcom_scm.h>
> 
> Can you check do we really need this header ?

Yeah it's needed for qcom_scm_assign_mem() API.

> 
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/remoteproc.h>
> > @@ -118,8 +119,8 @@ struct qcom_pas {
> >  	struct qcom_rproc_ssr ssr_subdev;
> >  	struct qcom_sysmon *sysmon;
> >  
> > -	struct qcom_scm_pas_context *pas_ctx;
> > -	struct qcom_scm_pas_context *dtb_pas_ctx;
> > +	struct qcom_pas_context *pas_ctx;
> > +	struct qcom_pas_context *dtb_pas_ctx;
> >  };
> >  
> >  static void qcom_pas_segment_dump(struct rproc *rproc,
> > @@ -196,7 +197,7 @@ static int qcom_pas_shutdown_poll_decrypt(struct qcom_pas *pas)
> >  
> >  	do {
> >  		msleep(QCOM_PAS_DECRYPT_SHUTDOWN_DELAY_MS);
> > -		ret = qcom_scm_pas_shutdown(pas->pas_id);
> > +		ret = qcom_pas_shutdown(pas->pas_id);
> >  	} while (ret == -EINVAL && --retry_num);
> >  
> >  	return ret;
> > @@ -212,9 +213,9 @@ static int qcom_pas_unprepare(struct rproc *rproc)
> >  	 * auth_and_reset() was successful, but in other cases clean it up
> >  	 * here.
> >  	 */
> > -	qcom_scm_pas_metadata_release(pas->pas_ctx);
> > +	qcom_pas_metadata_release(pas->pas_ctx);
> >  	if (pas->dtb_pas_id)
> > -		qcom_scm_pas_metadata_release(pas->dtb_pas_ctx);
> > +		qcom_pas_metadata_release(pas->dtb_pas_ctx);
> >  
> >  	return 0;
> >  }
> > @@ -228,9 +229,9 @@ static int qcom_pas_load(struct rproc *rproc, const struct firmware *fw)
> >  	pas->firmware = fw;
> >  
> >  	if (pas->lite_pas_id)
> > -		qcom_scm_pas_shutdown(pas->lite_pas_id);
> > +		qcom_pas_shutdown(pas->lite_pas_id);
> >  	if (pas->lite_dtb_pas_id)
> > -		qcom_scm_pas_shutdown(pas->lite_dtb_pas_id);
> > +		qcom_pas_shutdown(pas->lite_dtb_pas_id);
> >  
> >  	if (pas->dtb_pas_id) {
> >  		ret = request_firmware(&pas->dtb_firmware, pas->dtb_firmware_name, pas->dev);
> > @@ -250,7 +251,7 @@ static int qcom_pas_load(struct rproc *rproc, const struct firmware *fw)
> >  	return 0;
> >  
> >  release_dtb_metadata:
> > -	qcom_scm_pas_metadata_release(pas->dtb_pas_ctx);
> > +	qcom_pas_metadata_release(pas->dtb_pas_ctx);
> >  	release_firmware(pas->dtb_firmware);
> >  
> >  	return ret;
> > @@ -310,7 +311,7 @@ static int qcom_pas_start(struct rproc *rproc)
> >  		if (ret)
> >  			goto disable_px_supply;
> >  
> > -		ret = qcom_scm_pas_prepare_and_auth_reset(pas->dtb_pas_ctx);
> > +		ret = qcom_pas_prepare_and_auth_reset(pas->dtb_pas_ctx);
> >  		if (ret) {
> >  			dev_err(pas->dev,
> >  				"failed to authenticate dtb image and release reset\n");
> > @@ -329,7 +330,7 @@ static int qcom_pas_start(struct rproc *rproc)
> >  	if (ret)
> >  		goto release_pas_metadata;
> >  
> > -	ret = qcom_scm_pas_prepare_and_auth_reset(pas->pas_ctx);
> > +	ret = qcom_pas_prepare_and_auth_reset(pas->pas_ctx);
> >  	if (ret) {
> >  		dev_err(pas->dev,
> >  			"failed to authenticate image and release reset\n");
> > @@ -339,13 +340,13 @@ static int qcom_pas_start(struct rproc *rproc)
> >  	ret = qcom_q6v5_wait_for_start(&pas->q6v5, msecs_to_jiffies(5000));
> >  	if (ret == -ETIMEDOUT) {
> >  		dev_err(pas->dev, "start timed out\n");
> > -		qcom_scm_pas_shutdown(pas->pas_id);
> > +		qcom_pas_shutdown(pas->pas_id);
> >  		goto unmap_carveout;
> >  	}
> >  
> > -	qcom_scm_pas_metadata_release(pas->pas_ctx);
> > +	qcom_pas_metadata_release(pas->pas_ctx);
> >  	if (pas->dtb_pas_id)
> > -		qcom_scm_pas_metadata_release(pas->dtb_pas_ctx);
> > +		qcom_pas_metadata_release(pas->dtb_pas_ctx);
> >  
> >  	/* firmware is used to pass reference from qcom_pas_start(), drop it now */
> >  	pas->firmware = NULL;
> > @@ -355,9 +356,9 @@ static int qcom_pas_start(struct rproc *rproc)
> >  unmap_carveout:
> >  	qcom_pas_unmap_carveout(rproc, pas->mem_phys, pas->mem_size);
> >  release_pas_metadata:
> > -	qcom_scm_pas_metadata_release(pas->pas_ctx);
> > +	qcom_pas_metadata_release(pas->pas_ctx);
> >  	if (pas->dtb_pas_id)
> > -		qcom_scm_pas_metadata_release(pas->dtb_pas_ctx);
> > +		qcom_pas_metadata_release(pas->dtb_pas_ctx);
> >  
> >  unmap_dtb_carveout:
> >  	if (pas->dtb_pas_id)
> > @@ -406,7 +407,7 @@ static int qcom_pas_stop(struct rproc *rproc)
> >  	if (ret == -ETIMEDOUT)
> >  		dev_err(pas->dev, "timed out on wait\n");
> >  
> > -	ret = qcom_scm_pas_shutdown(pas->pas_id);
> > +	ret = qcom_pas_shutdown(pas->pas_id);
> >  	if (ret && pas->decrypt_shutdown)
> >  		ret = qcom_pas_shutdown_poll_decrypt(pas);
> >  
> > @@ -414,7 +415,7 @@ static int qcom_pas_stop(struct rproc *rproc)
> >  		dev_err(pas->dev, "failed to shutdown: %d\n", ret);
> >  
> >  	if (pas->dtb_pas_id) {
> > -		ret = qcom_scm_pas_shutdown(pas->dtb_pas_id);
> > +		ret = qcom_pas_shutdown(pas->dtb_pas_id);
> >  		if (ret)
> >  			dev_err(pas->dev, "failed to shutdown dtb: %d\n", ret);
> >  
> > @@ -484,11 +485,11 @@ static int qcom_pas_parse_firmware(struct rproc *rproc, const struct firmware *f
> >  	 *
> >  	 * Here, we call rproc_elf_load_rsc_table() to check firmware binary has resources
> >  	 * or not and if it is not having then we pass NULL and zero as input resource
> > -	 * table pointer and size respectively to the argument of qcom_scm_pas_get_rsc_table()
> > +	 * table pointer and size respectively to the argument of qcom_pas_get_rsc_table()
> >  	 * and this is even true for Qualcomm remote processor who does follow remoteproc
> >  	 * framework.
> >  	 */
> > -	output_rt = qcom_scm_pas_get_rsc_table(pas->pas_ctx, table, table_sz, &output_rt_size);
> > +	output_rt = qcom_pas_get_rsc_table(pas->pas_ctx, table, table_sz, &output_rt_size);
> >  	ret = IS_ERR(output_rt) ? PTR_ERR(output_rt) : 0;
> >  	if (ret) {
> >  		dev_err(pas->dev, "Error in getting resource table: %d\n", ret);
> > @@ -746,7 +747,7 @@ static int qcom_pas_probe(struct platform_device *pdev)
> >  	if (!desc)
> >  		return -EINVAL;
> >  
> > -	if (!qcom_scm_is_available())
> > +	if (!qcom_pas_is_available())
> >  		return -EPROBE_DEFER;
> >  
> >  	fw_name = desc->firmware_name;
> > @@ -838,16 +839,16 @@ static int qcom_pas_probe(struct platform_device *pdev)
> >  
> >  	qcom_add_ssr_subdev(rproc, &pas->ssr_subdev, desc->ssr_name);
> >  
> > -	pas->pas_ctx = devm_qcom_scm_pas_context_alloc(pas->dev, pas->pas_id,
> > -						       pas->mem_phys, pas->mem_size);
> > +	pas->pas_ctx = devm_qcom_pas_context_alloc(pas->dev, pas->pas_id,
> > +						   pas->mem_phys, pas->mem_size);
> >  	if (IS_ERR(pas->pas_ctx)) {
> >  		ret = PTR_ERR(pas->pas_ctx);
> >  		goto remove_ssr_sysmon;
> >  	}
> >  
> > -	pas->dtb_pas_ctx = devm_qcom_scm_pas_context_alloc(pas->dev, pas->dtb_pas_id,
> > -							   pas->dtb_mem_phys,
> > -							   pas->dtb_mem_size);
> > +	pas->dtb_pas_ctx = devm_qcom_pas_context_alloc(pas->dev, pas->dtb_pas_id,
> > +						       pas->dtb_mem_phys,
> > +						       pas->dtb_mem_size);
> >  	if (IS_ERR(pas->dtb_pas_ctx)) {
> >  		ret = PTR_ERR(pas->dtb_pas_ctx);
> >  		goto remove_ssr_sysmon;
> > -- 
> > 2.51.0
> > 
> 
> Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

Thanks.

-Sumit

